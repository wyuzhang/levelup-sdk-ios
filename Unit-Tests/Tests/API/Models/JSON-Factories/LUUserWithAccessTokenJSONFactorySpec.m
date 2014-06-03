#import "LUAccessToken.h"
#import "LUAccessTokenJSONFactory.h"
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "LUUserWithAccessToken.h"
#import "LUUserWithAccessTokenJSONFactory.h"

SPEC_BEGIN(LUUserWithAccessTokenJSONFactorySpec)

describe(@"LUUserWithAccessTokenJSONFactory", ^{
  __block LUUserWithAccessTokenJSONFactory *factory;

  beforeEach(^{
    factory = [LUUserWithAccessTokenJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUUserWithAccessToken", ^{
      NSDictionary *JSON = @{
        @"access_token": @{
          @"token": @"abc123"
        },
        @"user": @{
          @"born_at" : @"2012-12-04T18:10:45-05:00",
          @"cause_id" : @1,
          @"connected_to_facebook" : @YES,
          @"custom_attributes" : @{@"key" : @"value"},
          @"debit_card_only" : @YES,
          @"email" : @"test@example.com",
          @"first_name" : @"Test",
          @"gender" : @"male",
          @"global_credit_amount" : @100,
          @"id" : @1,
          @"last_name" : @"User",
          @"merchants_visited_count" : @5,
          @"orders_count" : @10,
          @"terms_accepted_at" : @"2012-12-04T18:10:45-05:00",
          @"total_savings_amount" : @200
        }
      };

      LUUserWithAccessToken *userWithAccessToken = [factory createFromAttributes:JSON];

      LUAccessToken *accessToken = [[LUAccessTokenJSONFactory factory] fromJSONObject:JSON[@"access_token"]];
      [[userWithAccessToken.accessToken should] equal:accessToken];

      LUUser *user = [[LUUserJSONFactory factory] fromJSONObject:JSON[@"user"]];
      [[userWithAccessToken.user should] equal:user];
    });
  });

  describe(@"rootKey", ^{
    it(@"is nil", ^{
      [[[factory rootKey] should] beNil];
    });
  });
});

SPEC_END
