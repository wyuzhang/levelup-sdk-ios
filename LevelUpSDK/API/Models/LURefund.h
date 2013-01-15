#import "LUAPIModel.h"

@class LUOrder;

@interface LURefund : LUAPIModel

@property (nonatomic, strong) LUOrder *order;

- (NSDate *)creationDate;

@end
