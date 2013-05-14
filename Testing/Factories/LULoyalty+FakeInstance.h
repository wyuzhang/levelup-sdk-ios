#import "LULoyalty.h"

@interface LULoyalty (FakeInstance)

+ (LULoyalty *)fakeInstance;
+ (LULoyalty *)fakeInstanceWithoutMerchantLoyaltyEnabled;

@end
