#import "LUAuthenticatedAPIRequest.h"
#import "LULoyaltyRequestFactory.h"
#import "LULoyaltyV14JSONFactory.h"

@implementation LULoyaltyRequestFactory

+ (LUAPIRequest *)requestForLoyaltyForMerchantWithID:(NSNumber *)merchantID {
  return [[LUAuthenticatedAPIRequest alloc] initWithMethod:@"GET"
                                         path:[NSString stringWithFormat:@"merchants/%@/loyalty", [merchantID stringValue]]
                                   apiVersion:LUAPIVersion14
                                   parameters:nil
                                 modelFactory:[LULoyaltyV14JSONFactory factory]];
}

@end
