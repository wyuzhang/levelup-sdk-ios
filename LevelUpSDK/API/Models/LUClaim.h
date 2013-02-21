#import "LUAPIModel.h"

/**
 When a user claims a campaign, an `LUClaim` object is created and returned.
 */
@class LUCampaign;
@class LUCohort;

@interface LUClaim : LUAPIModel

/**
 The campaign associated with this claim.
 */
@property (nonatomic, strong) LUCampaign *campaign;

/**
 The unique identifier for this claim.
 */
@property (nonatomic, copy) NSNumber *claimID;

/**
 The cohort through which the user claimed the campaign.
 */
@property (nonatomic, strong) LUCohort *cohort;

/**
 A cohort that may be shared by the user after completing the claim.
 */
@property (nonatomic, strong) LUCohort *shareCohort;

@end
