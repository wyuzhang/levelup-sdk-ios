@interface LUOrder (FakeInstance)

+ (LUOrder *)fakeInstance;

+ (LUOrder *)fakeInstanceWithOnlySpend;
+ (LUOrder *)fakeInstanceWithOnlySpendAndDonation;

+ (LUOrder *)fakeInstanceWithCredit:(LUMonetaryValue *)credit;
+ (LUOrder *)fakeInstanceWithDonation:(LUDonation *)donation;
+ (LUOrder *)fakeInstanceWithEarn:(LUMonetaryValue *)earn;
+ (LUOrder *)fakeInstanceWithTip:(LUMonetaryValue *)tip;

+ (LUOrder *)fakeInstanceWithoutTip;
+ (LUOrder *)fakeInstanceWithoutDonation;
+ (LUOrder *)fakeInstanceWithZeroBalance;
+ (LUOrder *)fakeInstanceWithoutCreditApplied;
+ (LUOrder *)fakeInstanceWithoutCreditEarned;
+ (LUOrder *)fakeInstanceWithMultipleMissingAttributes;

+ (LUOrder *)fakeInstanceWithPendingStatus;
+ (LUOrder *)fakeInstanceWithRefundedStatus;

+ (LUOrder *)fakeInstanceWithoutInterstitial;
+ (LUOrder *)fakeInstanceWithoutLoyalty;

@end
