// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIRequest.h"
#import "LULoyaltyJSONFactory.h"
#import "LULoyaltyRequestFactory.h"

@implementation LULoyaltyRequestFactory

+ (LUAPIRequest *)requestForLoyaltyForMerchantWithID:(NSNumber *)merchantID {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:[NSString stringWithFormat:@"merchants/%@/loyalty", [merchantID stringValue]]
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LULoyaltyJSONFactory factory]];
}

@end
