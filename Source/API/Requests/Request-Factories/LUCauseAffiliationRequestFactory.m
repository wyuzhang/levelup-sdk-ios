#import "LUAuthenticatedAPIRequest.h"
#import "LUCauseAffiliation.h"
#import "LUCauseAffiliationJSONFactory.h"
#import "LUCauseAffiliationRequestFactory.h"

@implementation LUCauseAffiliationRequestFactory

+ (LUAPIRequest *)requestForCauseAffiliation {
  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:@"/causes/affiliation"
                                              apiVersion:LUAPIVersion14
                                              parameters:nil
                                            modelFactory:[LUCauseAffiliationJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateCauseAffiliation:(LUCauseAffiliation *)causeAffiliation {
  NSDictionary *parameters = @{@"cause_id" : causeAffiliation.causeID, @"percent_donation" : causeAffiliation.percentDonation};

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"PUT"
                                                    path:@"/causes/affiliation"
                                              apiVersion:LUAPIVersion14
                                              parameters:@{@"cause_affiliation" : parameters}
                                            modelFactory:nil];
}

+ (LUAPIRequest *)requestToRemoveCauseAffiliation {
  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"DELETE"
                                                    path:@"/causes/affiliation"
                                              apiVersion:LUAPIVersion14
                                              parameters:nil
                                            modelFactory:nil];
}

@end
