/**
 `LUClaimRequestBuilder` is used to build requests related to claims.
 */
@class LUCohort;
@class LUAPIRequest;

@interface LUClaimRequestBuilder : NSObject

/**
 Builds a request to claim a cohort.

 On success, this request will return an instance of `LUClaim`.

 @param cohort The cohort to claim.
 */
+ (LUAPIRequest *)requestToClaimCohort:(LUCohort *)cohort;

/**
 Builds a request to claim a legacy loyalty campaign.

 On success, this request will return an `NSDictionary` with two keys: "claim" and "merchant", which have an `LUClaim`
 and `LUMerchant` as values, respectively.

 @param legacyId An identifying string. For example, a user's loyalty card number.
 @param campaignId The ID of the campaign to claim.
 */
+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithId:(NSString *)legacyId campaignId:(NSNumber *)campaignId;

@end
