#import "LUClaim+Fixtures.h"
#import "LULegacyLoyaltyClaim+Fixtures.h"
#import "LUMerchant+Fixtures.h"

@implementation LULegacyLoyaltyClaim (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"claim" : [LUClaim fullJSONObject],
    @"merchant" : [LUMerchant fullJSONObject]
  };
}

@end
