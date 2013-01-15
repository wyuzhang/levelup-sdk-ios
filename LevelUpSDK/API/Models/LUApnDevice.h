#import "LUAPIModel.h"

@interface LUApnDevice : LUAPIModel

@property (nonatomic, copy) NSNumber *development;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSString *token;

+ (void)registerDeviceToken:(NSData *)deviceToken sandbox:(BOOL)sandbox;
+ (void)unregisterDeviceToken;

@end
