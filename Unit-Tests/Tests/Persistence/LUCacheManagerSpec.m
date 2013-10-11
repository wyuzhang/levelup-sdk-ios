// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCacheManager.h"
#import "LUKeychainAccess+StubbingAdditions.h"

SPEC_BEGIN(LUCacheManagerSpec)

describe(@"LUCacheManager", ^{
  __block LUKeychainAccess *keychainAccess;

  beforeAll(^{
    [LUKeychainAccess stubKeychainAccess];

    keychainAccess = [LUKeychainAccess nullMock];
    [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:keychainAccess];
  });

  beforeEach(^{
    [LUKeychainAccess clearKeychainData];
  });

  describe(@"caching loyalty", ^{
    LULoyalty *loyalty = [LULoyalty fakeInstance];

    context(@"when loyalty gets cached", ^{
      it(@"saves the loyalty into the keychain", ^{
        [[[keychainAccess should] receive] setObject:loyalty forKey:LUCachedLoyaltyKey];

        [LUCacheManager cacheLoyalty:loyalty];
      });

      it(@"saves the loyalty in memory", ^{
        [LUCacheManager cacheLoyalty:loyalty];

        [[[keychainAccess shouldNot] receive] objectForKey:LUCachedLoyaltyKey];

        [[[LUCacheManager cachedLoyalty] should] equal:loyalty];
      });
    });

    context(@"when loyalty is cached in the keychain but not in memory", ^{
      beforeEach(^{
        [LUCacheManager cacheLoyalty:nil];
        [[keychainAccess stubAndReturn:loyalty] objectForKey:LUCachedLoyaltyKey];
      });

      it(@"returns the cached loyalty", ^{
        [[[LUCacheManager cachedLoyalty] should] equal:loyalty];
      });

      it(@"retrieves the loyalty from the keychain once, then stores it in memory", ^{
        [[[keychainAccess should] receiveWithCount:1] objectForKey:LUCachedLoyaltyKey];

        [[[LUCacheManager cachedLoyalty] should] equal:loyalty];
        [[[LUCacheManager cachedLoyalty] should] equal:loyalty];
      });
    });
  });

  describe(@"caching a user", ^{
    LUUser *user = [LUUser fakeInstance];

    context(@"when a user gets cached", ^{
      it(@"saves the user into the keychain", ^{
        [[[keychainAccess should] receive] setObject:user forKey:LUCachedUserKey];

        [LUCacheManager cacheUser:user];
      });

      it(@"saves the user in memory", ^{
        [LUCacheManager cacheUser:user];

        [[[keychainAccess shouldNot] receive] objectForKey:LUCachedUserKey];

        [[[LUCacheManager cachedUser] should] equal:user];
      });
    });

    context(@"when a user is cached in the keychain but not in memory", ^{
      beforeEach(^{
        [LUCacheManager cacheUser:nil];
        [[keychainAccess stubAndReturn:user] objectForKey:LUCachedUserKey];
      });

      it(@"returns the cached user", ^{
        [[[LUCacheManager cachedUser] should] equal:user];
      });

      it(@"retrieves the user from the keychain once, then stores it in memory", ^{
        [[[keychainAccess should] receiveWithCount:1] objectForKey:LUCachedUserKey];

        [LUCacheManager cachedUser];
        [LUCacheManager cachedUser];
      });
    });
  });
});

SPEC_END
