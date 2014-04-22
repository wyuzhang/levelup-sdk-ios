// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

extern NSString * const LUNextPageURLKey;

@protocol LULocationCacheUpdaterDelegate;

/**
 `LULocationCacheUpdater` is used to update the local database of summary info for all LevelUp
 locations.

 An initial database seed is provided in the SDK, and only changes to locations are sent from the
 platform.

 Updates are made in the background. A `LULocationCacheUpdaterDelegate` is provided, and will be
 notified when update finishes, and whether any updates were made. The delegate is also notified of
 any errors, either with Core Data or over the network.
 */
@interface LULocationCacheUpdater : NSObject

@property (nonatomic, assign, readonly) BOOL isUpdating;

- (id)initWithDelegate:(id<LULocationCacheUpdaterDelegate>)delegate;
- (void)startUpdating;
- (void)stopUpdating;

@end

@protocol LULocationCacheUpdaterDelegate <NSObject>

- (void)locationCacheUpdaterDidFinishWithUpdates:(BOOL)updates;
- (void)locationCacheUpdaterDidReceiveCoreDataError:(NSError *)error;
- (void)locationCacheUpdaterDidReceiveNetworkError:(NSError *)error;

@end
