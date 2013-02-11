#import "LUAPIModel.h"

@interface LUApnDevice : LUAPIModel

@property (nonatomic, assign) BOOL development;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSData *token;

@end
