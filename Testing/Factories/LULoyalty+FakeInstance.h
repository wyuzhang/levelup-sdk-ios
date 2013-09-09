// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULoyalty.h"

@interface LULoyalty (FakeInstance)

+ (LULoyalty *)fakeInstance;
+ (LULoyalty *)fakeInstanceWithoutMerchantLoyaltyEnabled;

@end
