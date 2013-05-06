extern NSString * const LUNextPageURLKey;

@protocol LULocationCacheUpdaterDelegate;

@interface LULocationCacheUpdater : NSObject

- (id)initWithDelegate:(id<LULocationCacheUpdaterDelegate>)delegate;
- (void)startUpdating;
- (void)stopUpdating;

@end

@protocol LULocationCacheUpdaterDelegate <NSObject>

- (void)locationCacheUpdaterDidFinishWithUpdates:(BOOL)updates;
- (void)locationCacheUpdaterDidReceiveCoreDataError:(NSError *)error;
- (void)locationCacheUpdaterDidReceiveNetworkError:(NSError *)error;

@end
