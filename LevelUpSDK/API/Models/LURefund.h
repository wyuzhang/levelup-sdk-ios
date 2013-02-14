#import "LUAPIModel.h"

/**
 Represents the refund of an order.
 */
@class LUOrder;

@interface LURefund : LUAPIModel

/**
 The order which was refunded.
 */
@property (nonatomic, strong) LUOrder *order;

/**
 The time at which the refund was made.
 */
- (NSDate *)creationDate;

@end
