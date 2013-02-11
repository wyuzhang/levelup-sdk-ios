@class LUCohort;
@class LUAPIRequest;

@interface LUClaimRequestBuilder : NSObject

+ (LUAPIRequest *)requestToClaimCohort:(LUCohort *)cohort;
+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithId:(NSString *)legacyId campaignId:(NSNumber *)campaignId;

@end
