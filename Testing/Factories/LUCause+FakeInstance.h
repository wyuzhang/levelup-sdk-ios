#import "LUCause.h"

@interface LUCause (FakeInstance)

+ (LUCause *)fakeInstanceWithAgeRequirement:(NSNumber *)age;
+ (LUCause *)fakeInstanceWithEmployerRequirement;
+ (LUCause *)fakeInstanceWithHomeAddressRequirement;
+ (LUCause *)fakeInstanceWithImageURL_1x:(NSURL *)imageURL_1x imageURL_2x:(NSURL *)imageURL_2x;
+ (LUCause *)fakeInstanceWithNoRequirements;
+ (LUCause *)fakeInstanceWithTerms:(NSString *)terms;
+ (LUCause *)fakeInstanceWithTwitterUsername:(NSString *)twitterUsername;

@end
