// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIRequest.h"
#import "LUPaymentTokenJSONFactory.h"
#import "LUPaymentTokenRequestFactory.h"

@implementation LUPaymentTokenRequestFactory

+ (LUAPIRequest *)requestForPaymentToken {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"payment_token"
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUPaymentTokenJSONFactory factory]];
}

@end
