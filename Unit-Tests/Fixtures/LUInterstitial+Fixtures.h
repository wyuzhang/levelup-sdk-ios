// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface LUInterstitial (Fixtures)

+ (LUInterstitial *)fullClaimActionInterstitial;
+ (NSDictionary *)fullClaimActionJSONObject;

+ (LUInterstitial *)fullNoActionInterstitial;
+ (NSDictionary *)fullNoActionJSONObject;

+ (LUInterstitial *)fullShareActionInterstitial;
+ (NSDictionary *)fullShareActionJSONObject;

+ (LUInterstitial *)fullURLActionInterstitial;
+ (NSDictionary *)fullURLActionJSONObject;

@end
