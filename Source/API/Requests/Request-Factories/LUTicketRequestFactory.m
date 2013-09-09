// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUTicketRequestFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUTicketRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToCreateTicketWithBody:(NSString *)body {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:body forKey:@"body"];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"POST"
                                                    path:@"tickets"
                                              apiVersion:LUAPIVersion14
                                              parameters:@{@"ticket" : parameters}
                                            modelFactory:nil];
}

@end
