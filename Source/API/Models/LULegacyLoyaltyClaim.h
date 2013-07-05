#import "LUAPIModel.h"

/**
 When a user claims a legacy loyalty campaign, an `LULegacyLoyaltyClaim` object is created and returned. This includes
 the `LUClaim` object for the claim as well as the `LUMerchant` at which the loyalty was claimed.
 */
@class LUClaim;
@class LUMerchant;

@interface LULegacyLoyaltyClaim : LUAPIModel

/**
 The `LUClaim` object for this claim.
 */
@property (nonatomic, strong, readonly) LUClaim *claim;

/**
 The `LUMerchant` at which this loyalty was claimed.
 */
@property (nonatomic, copy, readonly) LUMerchant *merchant;

- (id)initWithClaim:(LUClaim *)claim merchant:(LUMerchant *)merchant;

@end
