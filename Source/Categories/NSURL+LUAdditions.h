// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface NSURL (LUAdditions)

+ (NSURL *)lu_imageURLForCampaignWithID:(NSNumber *)campaignID;
+ (NSURL *)lu_imageURLForImageWithBase:(NSURL *)baseURL;
+ (NSURL *)lu_imageURLForLocationWithID:(NSNumber *)locationID;
+ (NSURL *)lu_URLWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path queryParameters:(NSDictionary *)queryParameters;
- (NSString *)lu_pathAndQueryWithoutAPIVersion;
- (NSDictionary *)lu_queryDictionary;

@end
