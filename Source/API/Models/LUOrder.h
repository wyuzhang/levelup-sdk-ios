#import "LUAPIModel.h"

/**
 `LUOrder` represents an order made using LevelUp.
 */
typedef NS_ENUM(NSInteger, LUOrderState) {
  LUOrderNoState,
  LUOrderProcessing,
  LUOrderCompleted,
  LUOrderRefunded
};

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
@property (nonatomic, strong, readonly) LUMonetaryValue *balance;

/**
 Specifies if this order is closed.
 */
@property (nonatomic, assign, readonly) BOOL closed;

/**
 The date that this order was made.
 */
@property (nonatomic, copy, readonly) NSDate *createdDate;

/**
 The amount of credit applied to this order.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *credit;

/**
 The donation associated with this order (if one was made).
 */
@property (nonatomic, strong, readonly) LUDonation *donation;

/**
 The amount of credit the user earned with this purchase.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *earn;

/**
 When displaying the receipt for this order, also show this intestitial action.
 */
@property (nonatomic, strong, readonly) LUInterstitialAction *interstitialAction;

/**
 The `LULocation` at which this order was made.
 */
@property (nonatomic, strong, readonly) LULocation *location;

/**
 The user's loyalty at the merchant at which the order was made.
 */
@property (nonatomic, strong, readonly) LULoyalty *loyalty;

/**
 The merchant at which the order was made.
 */
@property (nonatomic, strong, readonly) LUMerchant *merchant;

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy, readonly) NSNumber *orderID;

/**
 The date that this order was refunded.
 */
@property (nonatomic, copy, readonly) NSDate *refundedDate;

/**
 The amount the user spent for this order, not including tip.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *spend;

/**
 The state of the order.
 */
@property (nonatomic, assign, readonly) LUOrderState state;

/**
 The tip made for this order.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *tip;

/**
 The sum of `spend` and `tip`.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *total;

- (id)initWithBalance:(LUMonetaryValue *)balance closed:(BOOL)closed
          createdDate:(NSDate *)createdDate credit:(LUMonetaryValue *)credit
             donation:(LUDonation *)donation earn:(LUMonetaryValue *)earn
   interstitialAction:(LUInterstitialAction *)interstitialAction location:(LULocation *)location
              loyalty:(LULoyalty *)loyalty merchant:(LUMerchant *)merchant
              orderID:(NSNumber *)orderID refundedDate:(NSDate *)refundedDate
                spend:(LUMonetaryValue *)spend state:(LUOrderState)state tip:(LUMonetaryValue *)tip
                total:(LUMonetaryValue *)total;

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
