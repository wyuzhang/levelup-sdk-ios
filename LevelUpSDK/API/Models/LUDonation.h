#import "LUAPIModel.h"

@class LUCause;
@class LUMonetaryValue;

@interface LUDonation : LUAPIModel

@property (nonatomic, strong) LUCause *cause;
@property (nonatomic, strong) LUMonetaryValue *value;

@end
