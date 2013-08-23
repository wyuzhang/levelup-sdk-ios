#import "LUCacheManager.h"
#import "LUKeychainAccess.h"

NSString * const LUCachedUserKey = @"LUCachedUserKey";
NSString * const LUCachedLoyaltyKey = @"LUCachedLoyaltyKey";

@implementation LUCacheManager

+ (LULoyalty *)cachedLoyalty {
  return [self cachedObjectForKey:LUCachedLoyaltyKey];
}

+ (LUUser *)cachedUser {
  return [self cachedObjectForKey:LUCachedUserKey];
}

+ (void)cacheUser:(LUUser *)user {
  [self cacheObject:user forKey:LUCachedUserKey];
}

+ (void)cacheLoyalty:(LULoyalty *)loyalty {
  [self cacheObject:loyalty forKey:LUCachedLoyaltyKey];
}

#pragma mark - Private Methods

+ (void)cacheObject:(id)object forKey:(NSString *)key {
  [[LUKeychainAccess standardKeychainAccess] setObject:object forKey:key];
}

+ (id)cachedObjectForKey:(NSString *)key {
  return [[LUKeychainAccess standardKeychainAccess] objectForKey:key];
}

@end
