@class LUOrder;

@interface LURefund : NSObject

@property (nonatomic, weak, readonly) NSDate *creationDate;
@property (nonatomic, strong) LUOrder *order;
@property (nonatomic, copy) NSNumber *modelId;

@end
