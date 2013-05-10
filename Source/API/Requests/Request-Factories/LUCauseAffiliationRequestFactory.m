#import "LUAuthenticatedAPIRequest.h"
#import "LUCauseAffiliation.h"
#import "LUCauseAffiliationJSONFactory.h"
#import "LUCauseAffiliationRequestFactory.h"

@implementation LUCauseAffiliationRequestFactory

+ (LUAPIRequest *)requestForCauseAffiliation {
  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:@"cause_affiliation"
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LUCauseAffiliationJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateCauseAffiliation:(LUCauseAffiliation *)causeAffiliation {
  NSDictionary *parameters = @{@"cause_id" : causeAffiliation.causeID, @"percent_donation" : causeAffiliation.percentDonation};

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"POST"
                                                    path:@"cause_affiliation"
                                              apiVersion:LUAPIVersion13
                                              parameters:parameters
                                            modelFactory:nil];
}

+ (LUAPIRequest *)requestToRemoveCauseAffiliation {
  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"DELETE"
                                                    path:@"cause_affiliation"
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:nil];
}

@end
