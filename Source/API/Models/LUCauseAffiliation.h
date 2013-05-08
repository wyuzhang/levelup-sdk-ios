#import "LUAPIModel.h"

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
