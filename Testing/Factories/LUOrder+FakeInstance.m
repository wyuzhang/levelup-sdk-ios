#import "LUDonation+FakeInstance.h"
#import "LUInterstitialAction+FakeInstance.h"
#import "LULocation+FakeInstance.h"
#import "LULoyalty+FakeInstance.h"
#import "LUMerchant+FakeInstance.h"
#import "LUMonetaryValue.h"
#import "LUOrder+FakeInstance.h"
#import "NSDate+StringFormats.h"

@implementation LUOrder (FakeInstance)

+ (LUOrder *)fakeInstance {
  return [[LUOrder alloc] initWithBalance:[LUMonetaryValue monetaryValueWithUSD:@5.46f]
                                   closed:YES
                              createdDate:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-24T16:58:23-05:00"]
                                   credit:[LUMonetaryValue monetaryValueWithUSD:@1.0f]
                                 donation:[LUDonation fakeInstance]
                                     earn:[LUMonetaryValue monetaryValueWithUSD:@2.0f]
                       interstitialAction:[LUInterstitialAction fakeInstanceForCustomerAquisition]
                                 location:[LULocation fakeInstance]
                                  loyalty:[LULoyalty fakeInstance]
                                 merchant:[LUMerchant fakeInstance]
                                  orderID:@1
                             refundedDate:nil
                                    spend:[LUMonetaryValue monetaryValueWithUSD:@4.99f]
                                    state:LUOrderCompleted
                                      tip:[LUMonetaryValue monetaryValueWithUSD:@0.98f]
                                    total:[LUMonetaryValue monetaryValueWithUSD:@4.48f]];
}

+ (LUOrder *)fakeInstanceWithOnlySpend {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"credit"];
  [order setValue:nil forKey:@"donation"];
  [order setValue:nil forKey:@"earn"];
  [order setValue:nil forKey:@"tip"];
  return order;
}

+ (LUOrder *)fakeInstanceWithOnlySpendAndDonation {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"credit"];
  [order setValue:nil forKey:@"earn"];
  [order setValue:nil forKey:@"tip"];
  return order;
}

+ (LUOrder *)fakeInstanceWithCredit:(LUMonetaryValue *)credit {
  LUOrder *order = [self fakeInstance];
  [order setValue:credit forKey:@"credit"];
  return order;
}

+ (LUOrder *)fakeInstanceWithDonation:(LUDonation *)donation {
  LUOrder *order = [self fakeInstance];
  [order setValue:donation forKey:@"donation"];
  return order;
}

+ (LUOrder *)fakeInstanceWithEarn:(LUMonetaryValue *)earn {
  LUOrder *order = [self fakeInstance];
  [order setValue:earn forKey:@"earn"];
  return order;
}

+ (LUOrder *)fakeInstanceWithTip:(LUMonetaryValue *)tip {
  LUOrder *order = [self fakeInstance];
  [order setValue:tip forKey:@"tip"];
  return order;
}

+ (LUOrder *)fakeInstanceWithoutTip {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"tip"];
  return order;
}

+ (LUOrder *)fakeInstanceWithoutDonation {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"donation"];
  return order;
}

+ (LUOrder *)fakeInstanceWithZeroBalance {
  LUOrder *order = [self fakeInstance];
  [order setValue:[LUMonetaryValue monetaryValueWithUSD:@0.0] forKey:@"balance"];
  return order;
}

+ (LUOrder *)fakeInstanceWithoutCreditApplied {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"credit"];
  return order;
}

+ (LUOrder *)fakeInstanceWithoutCreditEarned {
  LUOrder *order = [self fakeInstance];
  [order setValue:[LUMonetaryValue monetaryValueWithUSD:@0.0] forKey:@"earn"];
  return order;
}

+ (LUOrder *)fakeInstanceWithMultipleMissingAttributes {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"donation"];
  [order setValue:[LUMonetaryValue monetaryValueWithUSD:@0.0] forKey:@"earn"];
  return order;
}

+ (LUOrder *)fakeInstanceWithPendingStatus {
  LUOrder *order = [self fakeInstance];
  [order setValue:@NO forKey:@"closed"];
  [order setValue:@(LUOrderProcessing) forKey:@"state"];
  return order;
}

+ (LUOrder *)fakeInstanceWithRefundedStatus {
  LUOrder *order = [self fakeInstance];
  [order setValue:[NSDate date] forKey:@"refundedDate"];
  return order;
}

+ (LUOrder *)fakeInstanceWithoutInterstitial {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"interstitialAction"];
  return order;
}

+ (LUOrder *)fakeInstanceWithoutLoyalty {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"loyalty"];
  [order setValue:[LUMerchant fakeInstanceWithoutLoyaltyEnabled] forKey:@"merchant"];
  return order;
}

@end
