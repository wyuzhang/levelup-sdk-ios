#import "LUBundle+FakeInstance.h"
#import "LUOrder+FakeInstance.h"
#import "LUMonetaryValue.h"
#import "LURefund+FakeInstance.h"

@implementation LUBundle (FakeInstance)

#pragma mark - Public Methods

+ (LUBundle *)fakeInstance {
  return [[LUBundle alloc] initWithAmount:[LUMonetaryValue monetaryValueWithUSD:@100]
                                 bundleID:@1
                               chargeDate:[NSDate date]
                                   closed:NO
                              createdDate:[NSDate date]
                    last4CreditCardDigits:@"1234"
                                   orders:@[[LUOrder fakeInstance]]
                                  refunds:@[[LURefund fakeInstance]]
                          totalCreditUsed:[LUMonetaryValue monetaryValueWithUSD:@10]];
}

+ (LUBundle *)fakeInstanceWithAmount:(LUMonetaryValue *)amount {
  LUBundle *bundle = [self fakeInstance];
  [bundle setValue:amount forKey:@"amount"];
  return bundle;
}

+ (LUBundle *)fakeInstanceWithOrders:(NSArray *)orders refunds:(NSArray *)refunds {
  LUBundle *bundle = [self fakeInstance];
  [bundle setValue:orders forKey:@"orders"];
  [bundle setValue:refunds forKey:@"refunds"];
  return bundle;
}

+ (LUBundle *)fakeInstanceWithTotalCreditUsed:(LUMonetaryValue *)totalCreditUsed {
  LUBundle *bundle = [self fakeInstance];
  [bundle setValue:totalCreditUsed forKey:@"totalCreditUsed"];
  return bundle;
}

@end
