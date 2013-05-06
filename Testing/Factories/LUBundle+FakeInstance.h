#import "LUBundle.h"

@interface LUBundle (FakeInstance)

+ (LUBundle *)fakeInstance;
+ (LUBundle *)fakeInstanceWithAmount:(LUMonetaryValue *)amount;
+ (LUBundle *)fakeInstanceWithOrders:(NSArray *)orders refunds:(NSArray *)refunds;
+ (LUBundle *)fakeInstanceWithTotalCreditUsed:(LUMonetaryValue *)totalCreditUsed;

@end
