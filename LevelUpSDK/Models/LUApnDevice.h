#import <Foundation/Foundation.h>

@interface LUApnDevice : NSObject

@property (nonatomic, copy) NSNumber *development;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *token;

+ (void)registerDeviceToken:(NSData *)deviceToken sandbox:(BOOL)sandbox;
+ (void)unregisterDeviceToken;
- (NSDictionary *)parameters;

@end
