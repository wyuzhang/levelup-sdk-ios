// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCachedLocation.h"
#import "LUCoreDataStack.h"
#import "LULocationCacheUpdater.h"
#import "LULocationRequestFactory.h"

SPEC_BEGIN(LULocationCacheUpdaterSpec)

describe(@"LULocationCacheUpdater", ^{
  __block LULocationCacheUpdater *updater;
  __block NSObject<LULocationCacheUpdaterDelegate> *delegate;
  __block NSManagedObjectContext *testManagedObjectContext;

  beforeEach(^{
    testManagedObjectContext = [NSManagedObjectContext testContext];
    [LUCoreDataStack stub:@selector(managedObjectContext) andReturn:testManagedObjectContext];

    [LUAPIClient setupWithAppID:@"1" APIKey:@"test" developmentMode:YES];
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

    __block LUAPIResponse *apiResponse1, *apiResponse2;

    beforeEach(^{
      apiResponse1 = [LUAPIResponse mock];
      [apiResponse1 stub:@selector(nextPageURL) andReturn:nextPage1];

      apiResponse2 = [LUAPIResponse mock];
      [apiResponse2 stub:@selector(nextPageURL) andReturn:nextPage2];
    });

    it(@"sets isUpdating to YES", ^{
      [updater startUpdating];

      [[theValue(updater.isUpdating) should] beYes];
    });

    context(@"when there are updates", ^{
      beforeEach(^{
        [[LUAPIClient sharedClient] stub:@selector(performRequest:success:failure:) withBlock:^id(NSArray *params) {
          LUAPIRequest *request = params[0];
          LUAPISuccessBlock successBlock = params[1];

          if ([request isEqual:[LULocationRequestFactory requestForLocationSummaries]]) {
            successBlock(@[location1, location2], apiResponse1);
          } else if ([request isEqual:[LULocationRequestFactory requestForLocationSummariesOnPage:nextPage1]]) {
            successBlock(@[location3, location4], apiResponse2);
          } else if ([request isEqual:[LULocationRequestFactory requestForLocationSummariesOnPage:nextPage2]]) {
            successBlock(nil, nil);
          }

          return nil;
        }];
      });

      it(@"starts retreiving pages from the last nextPageURL stored in the metadata", ^{
        NSURL *testNextPageURL = [NSURL URLWithString:@"http://example.com"];

        NSMutableDictionary *metadata = [[testManagedObjectContext.persistentStoreCoordinator.persistentStores[0] metadata] mutableCopy];
        metadata[LUNextPageURLKey] = [testNextPageURL absoluteString];
        [testManagedObjectContext.persistentStoreCoordinator.persistentStores[0] setMetadata:metadata];
        [testManagedObjectContext save:nil];

        [[[LULocationRequestFactory should] receive] requestForLocationSummariesOnPage:testNextPageURL];

        [updater startUpdating];
      });

      it(@"updates the cache with location summary updates across multiple pages", ^{
        [updater startUpdating];

        [[expectFutureValue(theValue(updater.isUpdating)) shouldEventually] beNo];

        NSInteger count = [testManagedObjectContext countForFetchRequest:[NSFetchRequest fetchRequestWithEntityName:[LUCachedLocation entityName]]
                                                                   error:nil];

        [[theValue(count) should] equal:theValue(4)];
      });

      it(@"notifies the delegate", ^{
        [[[delegate shouldEventually] receive] locationCacheUpdaterDidFinishWithUpdates:YES];

        [updater startUpdating];

        [[expectFutureValue(theValue(updater.isUpdating)) shouldEventually] beNo];
      });

      it(@"updates the saved nextPageURL in the metadata", ^{
        [updater startUpdating];

        [[expectFutureValue(theValue(updater.isUpdating)) shouldEventually] beNo];

        NSDictionary *metadata = [testManagedObjectContext.persistentStoreCoordinator.persistentStores[0] metadata];
        [[metadata[LUNextPageURLKey] should] equal:[nextPage2 absoluteString]];
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
          [[[delegate shouldEventually] receive] locationCacheUpdaterDidReceiveNetworkError:networkError];

          [updater startUpdating];
        });
      });

      context(@"when there is a Core Data error", ^{
        beforeEach(^{
          [testManagedObjectContext stub:@selector(save:) andReturn:theValue(NO)];
        });

        it(@"notifies the delegate of the error", ^{
          [[[delegate shouldEventually] receiveWithCountAtLeast:1] locationCacheUpdaterDidReceiveCoreDataError:nil];

          [updater startUpdating];

          [[expectFutureValue(theValue(updater.isUpdating)) shouldEventually] beNo];
        });
      });
    });

    context(@"when there are no updates", ^{
      beforeEach(^{
        [[LUAPIClient sharedClient] stub:@selector(performRequest:success:failure:) withBlock:^id(NSArray *params) {
          LUAPISuccessBlock successBlock = params[1];
          successBlock(nil, nil);

          return nil;
        }];
      });

      it(@"notifies the delegate", ^{
        [[[delegate shouldEventually] receive] locationCacheUpdaterDidFinishWithUpdates:NO];

        [updater startUpdating];
      });
    });
  });

  describe(@"stopUpdating", ^{
    context(@"when the updater is updating", ^{
      beforeEach(^{
        [updater startUpdating];
      });

      it(@"sets isUpdating to NO", ^{
        [updater stopUpdating];

        [[theValue(updater.isUpdating) should] beNo];
      });

      it(@"cancels the current request", ^{
        AFHTTPRequestOperation *fakeOperation = [NSOperation mock];
        LUAPIConnection *connection = [[LUAPIConnection alloc] initWithAFHTTPRequestOperation:fakeOperation];
        [updater setValue:connection forKey:@"currentRequest"];

        [[[fakeOperation should] receive] cancel];

        [updater stopUpdating];
      });
    });
  });
});

SPEC_END
