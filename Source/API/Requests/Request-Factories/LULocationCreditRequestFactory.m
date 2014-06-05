// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LULocationCreditJSONFactory.h"
#import "LULocationCreditRequestFactory.h"

@implementation LULocationCreditRequestFactory

+ (LUAPIRequest *)requestForCreditAtLocationID:(NSNumber *)locationID {
  NSString *path = [NSString stringWithFormat:@"locations/%@/credit", [locationID stringValue]];
  NSString *apiVersion = [LUAPIClient sharedClient].accessToken ? LUAPIVersion15 : LUAPIVersion14;

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:apiVersion
                                 parameters:nil
                               modelFactory:[LULocationCreditJSONFactory factory]];
}

@end
