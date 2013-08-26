#import "LUClaim.h"
#import "LUClaimJSONFactory.h"
#import "LUMonetaryValue.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUClaimJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *campaignID = [attributes lu_numberForKey:@"campaign_id"];
  NSNumber *claimID = [attributes lu_numberForKey:@"id"];
  NSString *code = [attributes lu_stringForKey:@"code"];
  LUMonetaryValue *value = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"value_amount"]];
  LUMonetaryValue *valueRemaining = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"value_remaining_amount"]];

  return [[LUClaim alloc] initWithCampaignID:campaignID claimID:claimID code:code value:value
                              valueRemaining:valueRemaining];
}

- (NSString *)rootKey {
  return @"claim";
}

@end
