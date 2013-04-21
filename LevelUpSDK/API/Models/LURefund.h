#import "LUAPIModel.h"

/**
 Represents the refund of an order.
 */
@class LUOrder;

@interface LURefund : LUAPIModel

/**
 The time at which the refund was made.
 */
@property (nonatomic, copy, readonly) NSDate *createdDate;

/**
 The order which was refunded.
 */
@property (nonatomic, strong, readonly) LUOrder *order;

/**
 The unique identifier for this refund.
 */
@property (nonatomic, copy, readonly) NSNumber *refundID;

- (id)initWithCreatedDate:(NSDate *)createdDate order:(LUOrder *)order refundID:(NSNumber *)refundID;

@end
