#import <Foundation/Foundation.h>

@class LUAPIRequest;
@class LUApnDevice;

@interface LUApnDeviceRequest : NSObject

+ (LUAPIRequest *)createApnDevice:(LUApnDevice *)apnDevice;

@end
