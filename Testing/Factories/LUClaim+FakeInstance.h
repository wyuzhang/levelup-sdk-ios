#import "LUClaim.h"

@interface LUClaim (FakeInstance)

+ (LUClaim *)fakeGlobalInstance;
+ (LUClaim *)fakeInstance;
+ (LUClaim *)fakeInstanceForMerchantWithID:(NSNumber *)merchantID;

@end
