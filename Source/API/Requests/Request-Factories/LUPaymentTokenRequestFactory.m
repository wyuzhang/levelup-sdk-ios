#import "LUAuthenticatedAPIRequest.h"
#import "LUPaymentTokenJSONFactory.h"
#import "LUPaymentTokenRequestFactory.h"

@implementation LUPaymentTokenRequestFactory

+ (LUAPIRequest *)requestForPaymentToken {
  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:@"payment_token"
                                              apiVersion:LUAPIVersion14
                                              parameters:nil
                                            modelFactory:[LUPaymentTokenJSONFactory factory]];
}

@end
