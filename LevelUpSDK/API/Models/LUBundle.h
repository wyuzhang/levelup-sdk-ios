#import "LUAPIModel.h"

/**
 `LUBundle` represents a bundle of orders on LevelUp. Typically LevelUp group orders together and charges a user
 once for the total sum of the orders.
 */

@class LUMonetaryValue;

@interface LUBundle : LUAPIModel

/**
 The total amount of the bundle.
 */
@property (nonatomic, strong) LUMonetaryValue *amount;

/**
 The unique identifier for this bundle.
 */
@property (nonatomic, copy) NSNumber *bundleID;

/**
 The date this bundle was charged.
 */
@property (nonatomic, copy) NSDate *chargedAt;

/**
 The date this bundle was created.
 */
@property (nonatomic, copy) NSDate *createdAt;

/**
 The last 4 digits of the credit card used to charge the bundle.
 */
@property (nonatomic, copy) NSString *last4CreditCardDigits;

/**
 An array of `LUOrder` objects contained in this bundle.
 */
@property (nonatomic, strong) NSArray *orders;

/**
 An array of `LURefund` objects contained in this bundle.
 */
@property (nonatomic, strong) NSArray *refunds;

/**
 The total amount of credit used in this bundle.
 */
@property (nonatomic, strong) LUMonetaryValue *totalCreditUsed;

/**
 Specifies if this bundle contains charge information (charge date, last 4 digits of credit card).
 */
- (BOOL)hasChargeData;

/**
 Specifies if this bundle's amount is non-zero.
 */
- (BOOL)hasNonZeroBalance;

/**
 Specifies if any credit was applied to this bundle.
 */
- (BOOL)hasSavings;

/**
 Specifies if this bundle is closed. Open bundles are still accepting orders and have not been charged yet.
 */
- (BOOL)isClosed;

/**
 An array of orders and refunds in this bundle, ordered by creation date, descending.
 */
- (NSArray *)ordersAndRefunds;

@end
