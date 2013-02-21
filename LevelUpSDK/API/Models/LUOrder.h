#import "LUAPIModel.h"

/**
 `LUOrder` represents an order made using LevelUp.
 */
@class LUBundle;
@class LUDonation;
@class LUInterstitialAction;
@class LULocation;
@class LULoyalty;
@class LUMerchant;
@class LUMonetaryValue;

@interface LUOrder : LUAPIModel

/**
 The amount of money that will be (or has been) charged to the user for this order.
 */
@property (nonatomic, strong) LUMonetaryValue *balance;

/**
 The bundle for this order (see documentation for `LUBundle` for a full discussion).
 */
@property (nonatomic, strong) LUBundle *bundle;

/**
 Specifies if this order is closed.
 */
@property (nonatomic, assign) BOOL closed;

/**
 The date that this order was made.
 */
@property (nonatomic, copy) NSDate *createdAt;

/**
 The amount of credit applied to this order.
 */
@property (nonatomic, strong) LUMonetaryValue *credit;

/**
 The donation associated with this order (if one was made).
 */
@property (nonatomic, strong) LUDonation *donation;

/**
 The amount of credit the user earned with this purchase.
 */
@property (nonatomic, strong) LUMonetaryValue *earn;

/**
 When displaying the receipt for this order, also show this intestitial action.
 */
@property (nonatomic, strong) LUInterstitialAction *interstitialAction;

/**
 The `LULocation` at which this order was made.
 */
@property (nonatomic, strong) LULocation *location;

/**
 The user's loyalty at the merchant at which the order was made.
 */
@property (nonatomic, strong) LULoyalty *loyalty;

/**
 The merchant at which the order was made.
 */
@property (nonatomic, strong) LUMerchant *merchant;

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy) NSNumber *orderID;

/**
 The date that this order was refunded.
 */
@property (nonatomic, copy) NSDate *refundedAt;

/**
 The amount the user spent for this order, not including tip.
 */
@property (nonatomic, strong) LUMonetaryValue *spend;

/**
 The state of the order. May be one of: 'processing', 'completed', or 'refunded'.
 */
@property (nonatomic, copy) NSString *state;

/**
 The tip made for this order.
 */
@property (nonatomic, strong) LUMonetaryValue *tip;

/**
 The sum of `spend` and `tip`.
 */
@property (nonatomic, strong) LUMonetaryValue *total;

/**
 Specifies if a donation was made on this order.
 */
- (BOOL)hasDonation;

/**
 Specifies if the user earned credit on this order.
 */
- (BOOL)hasEarnedCredit;

/**
 Specifies if this order has a non-zero balance.
 */
- (BOOL)hasNonZeroBalance;

/**
 Specifies if this order included a tip.
 */
- (BOOL)hasTipApplied;

/**
 Specifies if credit was used on this order.
 */
- (BOOL)hasUsedCredit;

/**
 Specifies if this order has been refunded.
 */
- (BOOL)wasRefunded;

@end
