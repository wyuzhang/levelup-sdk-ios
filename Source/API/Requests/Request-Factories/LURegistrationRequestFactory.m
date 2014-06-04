// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LURegistrationJSONFactory.h"
#import "LURegistrationRequestFactory.h"

@implementation LURegistrationRequestFactory

+ (LUAPIRequest *)requestForRegistrationWithEmail:(NSString *)email {
  NSDictionary *parameters = @{@"api_key": [LUAPIClient sharedClient].apiKey, @"email": email};

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"registration"
                                 apiVersion:LUAPIVersion15
                                 parameters:parameters
                               modelFactory:[LURegistrationJSONFactory factory]];
}

@end
