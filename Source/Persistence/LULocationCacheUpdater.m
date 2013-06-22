#import "LUAPIClient.h"
#import "LUAPIConnection.h"
#import "LUCachedLocation.h"
#import "LUCoreDataStack.h"
#import "LULocation.h"
#import "LULocationCacheUpdater.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaries.h"

NSString * const LUNextPageURLKey = @"LULocationCacheUpdaterNextPageURLKey";

@interface LULocationCacheUpdater ()

@property (nonatomic, weak) LUAPIConnection *currentRequest;
@property (nonatomic, weak) id<LULocationCacheUpdaterDelegate> delegate;
@property (nonatomic, assign) BOOL isUpdating;
@property (nonatomic, assign) BOOL locationsChanged;
@property (nonatomic, assign) dispatch_queue_t locationUpdaterQueue;

@end

@implementation LULocationCacheUpdater

#pragma mark - Creation

- (id)initWithDelegate:(id<LULocationCacheUpdaterDelegate>)delegate {
  self = [super init];
  if (!self) return nil;

  _delegate = delegate;
  _locationUpdaterQueue = dispatch_queue_create("LULocationUpdaterQueue", DISPATCH_QUEUE_SERIAL);

  return self;
}

- (void)dealloc {
  dispatch_release(_locationUpdaterQueue);
}

#pragma mark - Public Methods

- (void)startUpdating {
  if (self.isUpdating) return;

  self.isUpdating = YES;

  NSURL *nextPageURL = [NSURL URLWithString:[LUCoreDataStack metadataStringForKey:LUNextPageURLKey]];
  [self retrieveNextPageOfLocations:nextPageURL];
}

- (void)stopUpdating {
  if (!self.isUpdating) return;

  self.isUpdating = NO;
  [self.currentRequest.operation cancel];
}

#pragma mark - Private Methods

- (void)coreDataError:(NSError *)error {
  dispatch_sync(dispatch_get_main_queue(), ^{
    self.isUpdating = NO;
    [self.delegate locationCacheUpdaterDidReceiveCoreDataError:error];
  });
}

- (void)finishedUpdatingLocations {
  dispatch_async(self.locationUpdaterQueue, ^{
    dispatch_sync(dispatch_get_main_queue(), ^{
      self.isUpdating = NO;
      [self.delegate locationCacheUpdaterDidFinishWithUpdates:self.locationsChanged];
    });
  });
}

- (void)retrieveNextPageOfLocations:(NSURL *)nextPageURL {
  self.currentRequest =
    [[LUAPIClient sharedClient] performRequest:[LULocationRequestFactory requestForLocationSummaryPage:nextPageURL]
                                       success:^(LULocationSummaries *summaries) {
                                         if (!summaries || !self.isUpdating) {
                                           [self finishedUpdatingLocations];
                                           return;
                                         }

                                         [self updateLocations:summaries];

                                         [self retrieveNextPageOfLocations:summaries.nextPageURL];
                                       }
                                       failure:^(NSError *error) {
                                         [self.delegate locationCacheUpdaterDidReceiveNetworkError:error];
                                       }];

  self.currentRequest.successCallbackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)updateLocations:(LULocationSummaries *)summaries {
  dispatch_async(self.locationUpdaterQueue, ^{
    NSManagedObjectContext *moc = [LUCoreDataStack managedObjectContext];
    for (LULocation *location in summaries.locations) {
      LUCachedLocation *cachedLocation = [LUCachedLocation findOrBuildWithLocationID:location.locationID managedObjectContext:moc];
      [cachedLocation updatePropertiesFromLocation:location];
    }

    if (![moc hasChanges]) {
      return;
    }

    NSError *error;
    if (![moc save:&error]) {
      [self coreDataError:error];
      return;
    }

    [LUCoreDataStack setMetadataString:[summaries.nextPageURL absoluteString] forKey:LUNextPageURLKey];

    self.locationsChanged = YES;
  });
}

@end
