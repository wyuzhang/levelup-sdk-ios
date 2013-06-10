#import "LUMonetaryValue.h"
#import "LUUser+FakeInstance.h"

@implementation LUUser (FakeInstance)

+ (LUUser *)fakeInstance {
  return [[LUUser alloc] initWithAbleToRefer:YES
                                   birthdate:[NSDate distantPast]
                         connectedToFacebook:YES
                                      credit:[LUMonetaryValue monetaryValueWithUSD:@10]
                            customAttributes:nil
                                       email:@"test@example.com"
                                    employer:@"ACME, Inc."
                                   firstName:@"Joe"
                                      gender:LUGenderMale
                                    lastName:@"Test"
                            loyaltiesSavings:[LUMonetaryValue monetaryValueWithUSD:@1]
                       merchantsVisitedCount:@5
                                 ordersCount:@10
                             paymentEligible:YES
                                paymentToken:@"abcdef"
                           termsAcceptedDate:[NSDate distantPast]
                                      userID:@1];
}

@end
