#import "LUAPIModel.h"

/**
 Represents a user's affiliation with a cause. When choosing a cause, the user also chooses a percent
 of their savings which will be donated to the cause.
 */
@class LUCause;

@interface LUCauseAffiliation : LUAPIModel

/**
 The ID of the user's `cause`. Cause chosen by the user to which they would like to donate a percentage of their
 savings. The percent is set in `percentDonation`.
 */
@property (nonatomic, copy, readonly) NSNumber *causeID;

/**
 The percent of savings that the user would like to donate to their chosen `cause`.
 */
@property (nonatomic, copy) NSNumber *percentDonation;

- (id)initWithCauseID:(NSNumber *)causeID
      percentDonation:(NSNumber *)percentDonation;

@end
