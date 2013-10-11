// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCacheManager.h"

NSString * const LUCachedLoyaltyKey = @"LUCachedLoyaltyKey";
NSString * const LUCachedUserKey = @"LUCachedUserKey";

static LULoyalty *_cachedLoyalty;
static LUUser *_cachedUser;

@implementation LUCacheManager

#pragma mark - Object Creation

+ (LULoyalty *)cachedLoyalty {
  if (_cachedLoyalty) return _cachedLoyalty;

  _cachedLoyalty = [self cachedObjectForKey:LUCachedLoyaltyKey];
  return _cachedLoyalty;
}

+ (LUUser *)cachedUser {
  if (_cachedUser) return _cachedUser;

  _cachedUser = [self cachedObjectForKey:LUCachedUserKey];
  return _cachedUser;
}

+ (void)cacheLoyalty:(LULoyalty *)loyalty {
  _cachedLoyalty = loyalty;
  [self cacheObject:loyalty forKey:LUCachedLoyaltyKey];
}

+ (void)cacheUser:(LUUser *)user {
  _cachedUser = user;
  [self cacheObject:user forKey:LUCachedUserKey];
}

#pragma mark - Private Methods

+ (void)cacheObject:(id)object forKey:(NSString *)key {
  [[self keychainAccess] setObject:object forKey:key];
}

+ (id)cachedObjectForKey:(NSString *)key {
  return [[self keychainAccess] objectForKey:key];
}

+ (LUKeychainAccess *)keychainAccess {
  return [LUKeychainAccess standardKeychainAccess];
}

@end
