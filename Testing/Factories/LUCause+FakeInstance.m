#import "LUCause+FakeInstance.h"

@implementation LUCause (FakeInstance)

+ (LUCause *)fakeInstanceWithAgeRequirement:(NSNumber *)age {
  LUCause *cause = [self fakeInstanceWithNoRequirements];
  [cause setValue:age forKey:@"minimumAgeRequired"];
  return cause;
}

+ (LUCause *)fakeInstanceWithEmployerRequirement {
  LUCause *cause = [self fakeInstanceWithNoRequirements];
  [cause setValue:@YES forKey:@"employerRequired"];
  return cause;
}

+ (LUCause *)fakeInstanceWithHomeAddressRequirement {
  LUCause *cause = [self fakeInstanceWithNoRequirements];
  [cause setValue:@YES forKey:@"homeAddressRequired"];
  return cause;
}

+ (LUCause *)fakeInstanceWithImageURL_1x:(NSURL *)imageURL_1x imageURL_2x:(NSURL *)imageURL_2x {
  LUCause *cause = [self fakeInstanceWithNoRequirements];
  [cause setValue:imageURL_1x forKey:@"imageURL_1x"];
  [cause setValue:imageURL_2x forKey:@"imageURL_2x"];
  return cause;
}

+ (LUCause *)fakeInstanceWithNoRequirements {
  return [[LUCause alloc] initWithCauseID:@1
                          descriptionHTML:nil
                         employerRequired:NO
                              facebookURL:nil
                                 featured:NO
                      homeAddressRequired:NO
                              imageURL_1x:[NSURL URLWithString:@"http://placekitten.com/g/280/128"]
                              imageURL_2x:[NSURL URLWithString:@"http://placekitten.com/g/560/256"]
                       minimumAgeRequired:nil
                                     name:@"Test Cause"
                     partnerSpecificTerms:nil
                          twitterUsername:nil
                               websiteURL:nil];
}

+ (LUCause *)fakeInstanceWithTerms:(NSString *)terms {
  LUCause *cause = [self fakeInstanceWithNoRequirements];
  [cause setValue:terms forKey:@"partnerSpecificTerms"];
  return cause;
}

+ (LUCause *)fakeInstanceWithTwitterUsername:(NSString *)twitterUsername {
  LUCause *cause = [self fakeInstanceWithNoRequirements];
  [cause setValue:twitterUsername forKey:@"twitterUsername"];
  return cause;
}

@end
