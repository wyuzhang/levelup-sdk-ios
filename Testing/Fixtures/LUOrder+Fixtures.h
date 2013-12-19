// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUMonetaryValue.h"
#import "LUOrder.h"

@interface LUOrder (Fixtures)

+ (LUOrder *)fixture;

+ (LUOrder *)fixtureWithOnlySpend;
+ (LUOrder *)fixtureWithOnlySpendAndContribution;

+ (LUOrder *)fixtureWithCredit:(LUMonetaryValue *)credit;
+ (LUOrder *)fixtureWithContribution:(LUMonetaryValue *)contribution;
+ (LUOrder *)fixtureWithEarn:(LUMonetaryValue *)earn;
+ (LUOrder *)fixtureWithTip:(LUMonetaryValue *)tip;

+ (LUOrder *)fixtureWithoutTip;
+ (LUOrder *)fixtureWithoutContribution;
+ (LUOrder *)fixtureWithZeroBalance;
+ (LUOrder *)fixtureWithoutCreditApplied;
+ (LUOrder *)fixtureWithoutCreditEarned;
+ (LUOrder *)fixtureWithMultipleMissingAttributes;

+ (LUOrder *)fixtureWithBundleOpen;
+ (LUOrder *)fixtureWithRefundedStatus;

@end
