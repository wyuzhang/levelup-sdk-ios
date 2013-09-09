// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUInterstitial.h"

@interface LUInterstitial (FakeInstance)

+ (LUInterstitial *)fakeInstanceWithClaimAction;
+ (LUInterstitial *)fakeInstanceWithNoAction;
+ (LUInterstitial *)fakeInstanceWithShareAction;
+ (LUInterstitial *)fakeInstanceWithURLAction;

@end
