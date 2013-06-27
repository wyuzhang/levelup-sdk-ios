#import "LUMonetaryValue.h"
#import "LUUser+FakeInstance.h"

@implementation LUUser (FakeInstance)

+ (LUUser *)fakeInstance {
  return [[LUUser alloc] initWithBirthdate:[NSDate distantPast]
                                   causeID:@1
                       connectedToFacebook:YES
                          customAttributes:nil
                                     email:@"test@example.com"
                                 firstName:@"Joe"
                                    gender:LUGenderMale
                              globalCredit:[LUMonetaryValue monetaryValueWithUSD:@10]
                                  lastName:@"Test"
                     merchantsVisitedCount:@5
                               ordersCount:@10
                             termsAccepted:YES
                              totalSavings:[LUMonetaryValue monetaryValueWithUSD:@1]
                                    userID:@1];
}

@end
