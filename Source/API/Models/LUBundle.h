#import "LUAPIModel.h"

/**
 `LUBundle` represents a bundle of orders on LevelUp. Typically LevelUp group orders together and
 charges a user once for the total sum of the orders.
 */

@class LUMonetaryValue;

@interface LUBundle : LUAPIModel

/**
 The total amount of the bundle.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *amount;

/**
 The unique identifier for this bundle.
 */
@property (nonatomic, copy, readonly) NSNumber *bundleID;

/**
 The date this bundle was charged.
 */
@property (nonatomic, copy, readonly) NSDate *chargeDate;

/**
 Specifies if this bundle is closed. Open bundles are still accepting orders and have not been
 charged yet.
 */
@property (nonatomic, assign, readonly) BOOL closed;

/**
 The date this bundle was created.
 */
@property (nonatomic, copy, readonly) NSDate *createdDate;

/**
 The last 4 digits of the credit card used to charge the bundle.
 */
@property (nonatomic, copy, readonly) NSString *last4CreditCardDigits;

/**
 An array of `LUOrder` objects contained in this bundle.
 */
@property (nonatomic, strong, readonly) NSArray *orders;

/**
 An array of `LURefund` objects contained in this bundle.
 */
@property (nonatomic, strong, readonly) NSArray *refunds;

/**
 The total amount of credit used in this bundle.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *totalCreditUsed;

- (id)initWithAmount:(LUMonetaryValue *)amount bundleID:(NSNumber *)bundleID chargeDate:(NSDate *)chargeDate
              closed:(BOOL)closed createdDate:(NSDate *)createdDate last4CreditCardDigits:(NSString *)last4CreditCardDigits
              orders:(NSArray *)orders refunds:(NSArray *)refunds totalCreditUsed:(LUMonetaryValue *)totalCreditUsed;

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
 An array of orders and refunds in this bundle, ordered by creation date, descending.
 */
- (NSArray *)ordersAndRefunds;

@end
