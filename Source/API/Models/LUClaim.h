// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

@class LUMonetaryValue;

/**
 When a user claims a campaign, an `LUClaim` object is created and returned.
 */
@interface LUClaim : LUAPIModel

/**
 The ID of the campaign that was claimed.
 */
@property (nonatomic, copy, readonly) NSNumber *campaignID;

/**
 The unique identifier for this claim.
 */
@property (nonatomic, copy, readonly) NSNumber *claimID;

/**
 The code of the campaign that was claimed.
 */
@property (nonatomic, copy, readonly) NSString *code;

/**
 The full value of the claim.
*/
@property (nonatomic, strong, readonly) LUMonetaryValue *value;

/**
 The value remaining on the claim. As the user spends money, this amount will go down, and will be zero once they've
 used up the full value of the claim.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *valueRemaining;

- (id)initWithCampaignID:(NSNumber *)campaignID claimID:(NSNumber *)claimID code:(NSString *)code
                   value:(LUMonetaryValue *)value valueRemaining:(LUMonetaryValue *)valueRemaining;

@end
