// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULocation+FakeInstance.h"
#import "LULoyalty+FakeInstance.h"
#import "LUMonetaryValue.h"
#import "LUOrder+FakeInstance.h"
#import "NSDate+StringFormats.h"

@implementation LUOrder (FakeInstance)

+ (LUOrder *)fakeInstance {
  return [[LUOrder alloc] initWithBalance:[LUMonetaryValue monetaryValueWithUSD:@5.46f]
                         bundleClosedDate:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-24T16:58:23-05:00"]
                         bundleDescriptor:@"LevelUp"
                             contribution:[LUMonetaryValue monetaryValueWithUSD:@0.49f]
                   contributionTargetName:@"Test Cause"
                              createdDate:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-24T16:58:23-05:00"]
                                   credit:[LUMonetaryValue monetaryValueWithUSD:@1.0f]
                                     earn:[LUMonetaryValue monetaryValueWithUSD:@2.0f]
                  locationExtendedAddress:@"Apt E"
                               locationID:@1
                         locationLocality:@"Boston"
                       locationPostalCode:@"01234"
                           locationRegion:@"MA"
                    locationStreetAddress:@"123 Main St."
                               merchantID:@2
                             merchantName:@"Test Merchant"
                             refundedDate:nil
                                    spend:[LUMonetaryValue monetaryValueWithUSD:@4.99f]
                                      tip:[LUMonetaryValue monetaryValueWithUSD:@0.98f]
                                    total:[LUMonetaryValue monetaryValueWithUSD:@4.48f]
                           transactedDate:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-24T16:58:23-05:00"]
                                     UUID:@"97067bb0f250013007de3c075468379e"];
}

+ (LUOrder *)fakeInstanceWithOnlySpend {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"credit"];
  [order setValue:nil forKey:@"contribution"];
  [order setValue:nil forKey:@"earn"];
  [order setValue:nil forKey:@"tip"];
  return order;
}

+ (LUOrder *)fakeInstanceWithOnlySpendAndContribution {
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

+ (LUOrder *)fakeInstanceWithContribution:(LUMonetaryValue *)contribution {
  LUOrder *order = [self fakeInstance];
  [order setValue:contribution forKey:@"contribution"];
  [order setValue:@"Test Charity" forKey:@"contributionTargetName"];
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

+ (LUOrder *)fakeInstanceWithoutContribution {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"contribution"];
  [order setValue:nil forKey:@"contributionTargetName"];
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
  [order setValue:nil forKey:@"contribution"];
  [order setValue:[LUMonetaryValue monetaryValueWithUSD:@0.0] forKey:@"earn"];
  return order;
}

+ (LUOrder *)fakeInstanceWithBundleOpen {
  LUOrder *order = [self fakeInstance];
  [order setValue:nil forKey:@"bundleClosedDate"];
  return order;
}

+ (LUOrder *)fakeInstanceWithRefundedStatus {
  LUOrder *order = [self fakeInstance];
  [order setValue:[NSDate date] forKey:@"refundedDate"];
  return order;
}

@end
