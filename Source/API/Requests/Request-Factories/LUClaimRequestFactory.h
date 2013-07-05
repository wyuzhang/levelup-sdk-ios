/**
 `LUClaimRequestFactory` is used to build requests related to claims.
 */
@class LUCohort;
@class LUAPIRequest;

@interface LUClaimRequestFactory : NSObject

/**
 Builds a request to claim a cohort.

 On success, this request will return an instance of `LUClaim`.

 @param cohort The cohort to claim.
 */
+ (LUAPIRequest *)requestToClaimCohort:(LUCohort *)cohort;

/**
 Builds a request to claim a legacy loyalty campaign.

 On success, this request will return an `LULegacyLoyaltyClaim`.

 @param legacyID An identifying string. For example, a user's loyalty card number.
 @param campaignID The ID of the campaign to claim.
 */
+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithID:(NSString *)legacyID campaignID:(NSNumber *)campaignID;

@end
