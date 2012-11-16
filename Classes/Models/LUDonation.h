#import <Foundation/Foundation.h>

@class LUCause;
@class LUMonetaryValue;

@interface LUDonation : NSObject

@property (nonatomic, strong) LUCause *cause;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, strong) LUMonetaryValue *value;

@end
