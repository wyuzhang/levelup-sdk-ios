// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface NSURL (LUAdditions)

+ (NSURL *)lu_imageURLForCampaignWithID:(NSNumber *)campaignID;
+ (NSURL *)lu_imageURLForImageWithBase:(NSURL *)baseURL;
+ (NSURL *)lu_imageURLForLocationWithID:(NSNumber *)locationID;

- (NSString *)lu_pathAndQueryWithoutAPIVersion;

@end
