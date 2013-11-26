// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIRequest.h"
#import "LULocationCreditJSONFactory.h"
#import "LULocationCreditRequestFactory.h"

@implementation LULocationCreditRequestFactory

+ (LUAPIRequest *)requestForCreditAtLocationID:(NSNumber *)locationID {
  NSString *path = [NSString stringWithFormat:@"locations/%@/credit", [locationID stringValue]];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationCreditJSONFactory factory]];
}

@end
