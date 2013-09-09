// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCacheManager.h"
#import "LUKeychainAccess+StubbingAdditions.h"

SPEC_BEGIN(LUCacheManagerSpec)

describe(@"LUCacheManager", ^{
  beforeAll(^{
    [LUKeychainAccess stubKeychainAccess];
  });

  beforeEach(^{
    [LUKeychainAccess clearKeychainData];
  });

  describe(@"caching users", ^{
    __block LUUser *user;

    beforeAll(^{
      user = [LUUser fakeInstance];
    });

    describe(@"cacheUserForJSON:", ^{
      it(@"should save the user JSON into the keychain", ^{
        [LUCacheManager cacheUser:user];
        [[[[LUKeychainAccess standardKeychainAccess] objectForKey:LUCachedUserKey] should] equal:user];
      });
    });

    describe(@"cachedUser", ^{
      beforeEach(^{
        [LUCacheManager cacheUser:user];
      });

      it(@"should return a User object created from the stored JSON", ^{
        LUUser *returnedUser = [LUCacheManager cachedUser];
        [[returnedUser should] equal:user];
      });
    });
  });

  describe(@"caching loyalty", ^{
    __block LULoyalty *loyalty;

    beforeAll(^{
      loyalty = [LULoyalty fakeInstance];
    });

    describe(@"cacheLoyaltyForJSON:", ^{
      it(@"should save the loyalty JSON into the keychain", ^{
        [LUCacheManager cacheLoyalty:loyalty];
        [[[[LUKeychainAccess standardKeychainAccess] objectForKey:LUCachedLoyaltyKey] should] equal:loyalty];
      });
    });

    describe(@"cachedLoyalty", ^{
      beforeEach(^{
        [LUCacheManager cacheLoyalty:loyalty];
      });

      it(@"should return a Loyalty object created from the stored JSON", ^{
        LULoyalty *returnedLoyalty = [LUCacheManager cachedLoyalty];
        [[returnedLoyalty should] equal:loyalty];
      });
    });
  });
});

SPEC_END
