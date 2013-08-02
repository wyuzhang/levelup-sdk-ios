#import "LUInterstitial.h"

@interface LUInterstitial (FakeInstance)

+ (LUInterstitial *)fakeInstanceWithClaimAction;
+ (LUInterstitial *)fakeInstanceWithNoAction;
+ (LUInterstitial *)fakeInstanceWithShareAction;
+ (LUInterstitial *)fakeInstanceWithURLAction;

@end
