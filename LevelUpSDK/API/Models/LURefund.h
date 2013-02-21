#import "LUAPIModel.h"

/**
 Represents the refund of an order.
 */
@class LUOrder;

@interface LURefund : LUAPIModel

/**
 The time at which the refund was made.
 */
@property (nonatomic, copy) NSDate *createdAt;

/**
 The order which was refunded.
 */
@property (nonatomic, strong) LUOrder *order;

/**
 The unique identifier for this refund.
 */
@property (nonatomic, copy) NSNumber *refundID;

@end
