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
@property (nonatomic, strong, readonly) LUCampaign *campaign;

/**
 The unique identifier for this claim.
 */
@property (nonatomic, copy, readonly) NSNumber *claimID;

/**
 The cohort through which the user claimed the campaign.
 */
@property (nonatomic, strong, readonly) LUCohort *cohort;

/**
 A cohort that may be shared by the user after completing the claim.
 */
@property (nonatomic, strong, readonly) LUCohort *shareCohort;

- (id)initWithCampaign:(LUCampaign *)campaign claimID:(NSNumber *)claimID cohort:(LUCohort *)cohort
           shareCohort:(LUCohort *)shareCohort;

@end
