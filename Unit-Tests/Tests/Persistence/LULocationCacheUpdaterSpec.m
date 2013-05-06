#import "LUCachedLocation.h"
#import "LUCoreDataStack.h"
#import "LULocationCacheUpdater.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaries.h"

SPEC_BEGIN(LULocationCacheUpdaterSpec)

describe(@"LULocationCacheUpdater", ^{
  __block LULocationCacheUpdater *updater;
  __block id<LULocationCacheUpdaterDelegate> delegate;
  __block NSManagedObjectContext *testManagedObjectContext;

  beforeEach(^{
    testManagedObjectContext = [NSManagedObjectContext testContext];
    [LUCoreDataStack stub:@selector(managedObjectContext) andReturn:testManagedObjectContext];

    [[[NSUserDefaults standardUserDefaults] stub] URLForKey:LUNextPageURLKey];

    [LUAPIClient setupWithAPIKey:@"test" developmentMode:YES];
    [[LUAPIClient sharedClient] stub:@selector(performRequest:success:failure:)];

    delegate = [KWMock nullMockForProtocol:@protocol(LULocationCacheUpdaterDelegate)];
    updater = [[LULocationCacheUpdater alloc] initWithDelegate:delegate];
  });

  // Public Methods

  describe(@"startUpdating", ^{
    NSURL *nextPage1 = [NSURL URLWithString:@"http://example.com/next1"];
    NSURL *nextPage2 = [NSURL URLWithString:@"http://example.com/next2"];

    LULocation *location1 = [LULocation fakeInstanceWithLocationID:@1];
    LULocation *location2 = [LULocation fakeInstanceWithLocationID:@2];

    LULocation *location3 = [LULocation fakeInstanceWithLocationID:@3];
    LULocation *location4 = [LULocation fakeInstanceWithLocationID:@4];

    LULocationSummaries *page1Summaries = [[LULocationSummaries alloc] initWithLocations:@[location1, location2]
                                                                             nextPageURL:nextPage1];

    LULocationSummaries *page2Summaries = [[LULocationSummaries alloc] initWithLocations:@[location3, location4]
                                                                             nextPageURL:nextPage2];

    context(@"when there are updates", ^{
      beforeEach(^{
        [[LUAPIClient sharedClient] stub:@selector(performRequest:success:failure:) withBlock:^id(NSArray *params) {
          LUAPIRequest *request = params[0];
          LUAPISuccessBlock successBlock = params[1];

          if ([request isEqual:[LULocationRequestFactory requestForLocationSummaries]]) {
            successBlock(page1Summaries);
          } else if ([request isEqual:[LULocationRequestFactory requestForLocationSummaryPage:nextPage1]]) {
            successBlock(page2Summaries);
          } else if ([request isEqual:[LULocationRequestFactory requestForLocationSummaryPage:nextPage2]]) {
            successBlock(nil);
          }

          return nil;
        }];
      });

      it(@"starts retreiving pages from the last nextPageURL stored in NSUserDefaults", ^{
        NSURL *testNextPageURL = [NSURL URLWithString:@"http://example.com"];

        [[[NSUserDefaults standardUserDefaults] stubAndReturn:testNextPageURL] URLForKey:LUNextPageURLKey];

        [[[LULocationRequestFactory should] receive] requestForLocationSummaryPage:testNextPageURL];

        [updater startUpdating];
      });

      it(@"updates the cache with location summary updates across multiple pages", ^{
        [updater startUpdating];

        NSInteger count = [testManagedObjectContext countForFetchRequest:[NSFetchRequest fetchRequestWithEntityName:[LUCachedLocation entityName]]
                                                                   error:nil];

        [[theValue(count) should] equal:theValue(4)];
      });

      it(@"notifies the delegate", ^{
        [[[(id)delegate should] receive] locationCacheUpdaterDidFinishWithUpdates:YES];

        [updater startUpdating];
      });

      it(@"updates the saved nextPageURL in NSUserDefaults", ^{
        [[[NSUserDefaults standardUserDefaults] stub] setURL:any() forKey:LUNextPageURLKey];

        [[[[NSUserDefaults standardUserDefaults] should] receive] setURL:nextPage2 forKey:LUNextPageURLKey];

        [updater startUpdating];
      });

      context(@"when there is a network error", ^{
        NSError *networkError = [NSError errorWithDomain:@"Network Error" code:0 userInfo:nil];

        beforeEach(^{
          [[LUAPIClient sharedClient] stub:@selector(performRequest:success:failure:) withBlock:^id(NSArray *params) {
            LUAPIFailureBlock failureBlock = params[2];
            failureBlock(networkError);

            return nil;
          }];
        });

        it(@"notifies the delegate of the error", ^{
          [[[(id)delegate should] receive] locationCacheUpdaterDidReceiveNetworkError:networkError];

          [updater startUpdating];
        });
      });

      context(@"when there is a Core Data error", ^{
        beforeEach(^{
          [testManagedObjectContext stub:@selector(save:) andReturn:theValue(NO)];
        });

        it(@"notifies the delegate of the error", ^{
          [[(id)delegate should] receive:@selector(locationCacheUpdaterDidReceiveCoreDataError:)];

          [updater startUpdating];
        });
      });
    });

    context(@"when there are no updates", ^{
      beforeEach(^{
        [[LUAPIClient sharedClient] stub:@selector(performRequest:success:failure:) withBlock:^id(NSArray *params) {
          LUAPISuccessBlock successBlock = params[1];
          successBlock(nil);

          return nil;
        }];
      });

      it(@"notifies the delegate", ^{
        [[[(id)delegate should] receive] locationCacheUpdaterDidFinishWithUpdates:NO];

        [updater startUpdating];
      });
    });
  });

  describe(@"stopUpdating", ^{
    it(@"cancels the current request", ^{
      NSOperation *fakeRequest = [NSOperation mock];
      [updater setValue:fakeRequest forKey:@"currentRequest"];

      [[[fakeRequest should] receive] cancel];

      [updater stopUpdating];
    });
  });
});

SPEC_END
