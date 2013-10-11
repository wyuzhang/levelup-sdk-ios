// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.
#import "LUKeychainAccess.h"

@class LULoyalty;
@class LUUser;

extern NSString * const LUCachedLoyaltyKey;
extern NSString * const LUCachedUserKey;

@interface LUCacheManager : NSObject

+ (LULoyalty *)cachedLoyalty;
+ (LUUser *)cachedUser;
+ (void)cacheLoyalty:(LULoyalty *)loyalty;
+ (void)cacheUser:(LUUser *)user;
+ (void)setKeychainErrorHandler:(id<LUKeychainErrorHandler>)keychainErrorHandler;

@end
