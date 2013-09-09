// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUOrder.h"

@interface LUOrder (FakeInstance)

+ (LUOrder *)fakeInstance;

+ (LUOrder *)fakeInstanceWithOnlySpend;
+ (LUOrder *)fakeInstanceWithOnlySpendAndContribution;

+ (LUOrder *)fakeInstanceWithCredit:(LUMonetaryValue *)credit;
+ (LUOrder *)fakeInstanceWithContribution:(LUMonetaryValue *)contribution;
+ (LUOrder *)fakeInstanceWithEarn:(LUMonetaryValue *)earn;
+ (LUOrder *)fakeInstanceWithTip:(LUMonetaryValue *)tip;

+ (LUOrder *)fakeInstanceWithoutTip;
+ (LUOrder *)fakeInstanceWithoutContribution;
+ (LUOrder *)fakeInstanceWithZeroBalance;
+ (LUOrder *)fakeInstanceWithoutCreditApplied;
+ (LUOrder *)fakeInstanceWithoutCreditEarned;
+ (LUOrder *)fakeInstanceWithMultipleMissingAttributes;

+ (LUOrder *)fakeInstanceWithBundleOpen;
+ (LUOrder *)fakeInstanceWithRefundedStatus;

@end
