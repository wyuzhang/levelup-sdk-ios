// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUInterstitial.h"

@interface LUInterstitial (Fixtures)

+ (LUInterstitial *)fixtureWithClaimAction;
+ (LUInterstitial *)fixtureWithFeedbackAction;
+ (LUInterstitial *)fixtureWithNoAction;
+ (LUInterstitial *)fixtureWithShareAction;
+ (LUInterstitial *)fixtureWithURLAction;

@end
