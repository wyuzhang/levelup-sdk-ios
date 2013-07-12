#import "LUAuthenticatedAPIRequest.h"
#import "LUCauseAffiliation.h"
#import "LUCauseAffiliationJSONFactory.h"
#import "LUCauseAffiliationRequestFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUCauseAffiliationRequestFactory

+ (LUAPIRequest *)requestForCauseAffiliation {
  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:@"cause_affiliation"
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LUCauseAffiliationJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateCauseAffiliation:(LUCauseAffiliation *)causeAffiliation {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:causeAffiliation.causeID forKey:@"cause_id"];
  [parameters lu_setSafeValue:causeAffiliation.percentDonation forKey:@"percent_donation"];

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
