#import "LUAccessToken.h"
#import "LUAccessTokenJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUAccessTokenJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *token = [attributes lu_stringForKey:@"token"];
  NSNumber *userID = [attributes lu_numberForKey:@"user_id"];

  return [[LUAccessToken alloc] initWithToken:token userID:userID];
}

- (NSString *)rootKey {
  return @"access_token";
}

@end
