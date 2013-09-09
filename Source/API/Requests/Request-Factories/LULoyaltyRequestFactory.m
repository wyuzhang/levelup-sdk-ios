// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAuthenticatedAPIRequest.h"
#import "LULoyaltyJSONFactory.h"
#import "LULoyaltyRequestFactory.h"

@implementation LULoyaltyRequestFactory

+ (LUAPIRequest *)requestForLoyaltyForMerchantWithID:(NSNumber *)merchantID {
  return [[LUAuthenticatedAPIRequest alloc] initWithMethod:@"GET"
                                         path:[NSString stringWithFormat:@"merchants/%@/loyalty", [merchantID stringValue]]
                                   apiVersion:LUAPIVersion14
                                   parameters:nil
                                 modelFactory:[LULoyaltyJSONFactory factory]];
}

@end
