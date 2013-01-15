@class LUCohort;
@class LUAPIRequest;

@interface LUClaimRequest : NSObject

+ (LUAPIRequest *)claimCohort:(LUCohort *)cohort;
+ (LUAPIRequest *)claimLegacyLoyaltyWihId:(NSString *)legacyId campaignId:(NSNumber *)campaignId;

@end
