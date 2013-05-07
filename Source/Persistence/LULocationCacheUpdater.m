#import "LUAPIClient.h"
#import "LUCachedLocation.h"
#import "LUCoreDataStack.h"
#import "LULocation.h"
#import "LULocationCacheUpdater.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaries.h"

NSString * const LUNextPageURLKey = @"LULocationCacheUpdaterNextPageURLKey";

@interface LULocationCacheUpdater ()

@property (nonatomic, weak) NSOperation *currentRequest;
@property (nonatomic, weak) id<LULocationCacheUpdaterDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, copy) NSURL *nextPageURL;

@end

@implementation LULocationCacheUpdater

#pragma mark - Creation

- (id)initWithDelegate:(id<LULocationCacheUpdaterDelegate>)delegate {
  self = [super init];
  if (!self) return nil;

  _delegate = delegate;

  return self;
}

#pragma mark - Public Methods

- (void)startUpdating {
  [self retrieveNextPageOfLocations];
}

- (void)stopUpdating {
  [self.currentRequest cancel];
}

#pragma mark - Private Methods (Properties)

- (NSURL *)nextPageURL {
  if (_nextPageURL) return _nextPageURL;

  _nextPageURL = [NSURL URLWithString:[LUCoreDataStack metadataStringForKey:LUNextPageURLKey]];
  return _nextPageURL;
}

- (NSManagedObjectContext *)managedObjectContext {
  if (_managedObjectContext) return _managedObjectContext;

  _managedObjectContext = [LUCoreDataStack managedObjectContext];

  return _managedObjectContext;
}

#pragma mark - Private Methods

- (void)finishedUpdatingLocations {
  if (![self.managedObjectContext hasChanges]) {
    [self.delegate locationCacheUpdaterDidFinishWithUpdates:NO];
    return;
  }

  NSError *error;
  if (![self.managedObjectContext save:&error]) {
    [self.delegate locationCacheUpdaterDidReceiveCoreDataError:error];
    return;
  }

  [LUCoreDataStack setMetadataString:[self.nextPageURL absoluteString] forKey:LUNextPageURLKey];

  [self.delegate locationCacheUpdaterDidFinishWithUpdates:YES];
}

- (void)retrieveNextPageOfLocations {
  self.currentRequest =
    [[LUAPIClient sharedClient] performRequest:[LULocationRequestFactory requestForLocationSummaryPage:self.nextPageURL]
                                       success:^(LULocationSummaries *summaries) {
                                         if (!summaries) {
                                           [self finishedUpdatingLocations];
                                           return;
                                         }

                                         [self updateLocations:summaries.locations];

                                         self.nextPageURL = summaries.nextPageURL;
                                         [self retrieveNextPageOfLocations];
                                       }
                                       failure:^(NSError *error) {
                                         [self.delegate locationCacheUpdaterDidReceiveNetworkError:error];
                                       }];
}

- (void)updateLocations:(NSArray *)locations {
  for (LULocation *location in locations) {
    LUCachedLocation *cachedLocation = [LUCachedLocation findOrBuildWithLocationID:location.locationID
                                                              managedObjectContext:self.managedObjectContext];
    [cachedLocation updatePropertiesFromLocation:location];
  }
}

@end
