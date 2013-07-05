#import "LUClaimJSONFactory.h"
#import "LULegacyLoyaltyClaim.h"
#import "LULegacyLoyaltyClaimJSONFactory.h"
#import "LUMerchantJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULegacyLoyaltyClaimJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUClaim *claim = [[LUClaimJSONFactory factory] fromJSONObject:attributes[@"claim"]];
  LUMerchant *merchant = [[LUMerchantJSONFactory factory] fromJSONObject:attributes[@"merchant"]];

  return [[LULegacyLoyaltyClaim alloc] initWithClaim:claim merchant:merchant];
}

@end
