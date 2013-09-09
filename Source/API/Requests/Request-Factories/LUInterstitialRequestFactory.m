// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAuthenticatedAPIRequest.h"
#import "LUInterstitialJSONFactory.h"
#import "LUInterstitialRequestFactory.h"

@implementation LUInterstitialRequestFactory

+ (LUAPIRequest *)requestForInterstitialForOrderWithUUID:(NSString *)UUID {
  NSString *path = [NSString stringWithFormat:@"orders/%@/interstitial", UUID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion14
                                              parameters:nil
                                            modelFactory:[LUInterstitialJSONFactory factory]];

}

@end
