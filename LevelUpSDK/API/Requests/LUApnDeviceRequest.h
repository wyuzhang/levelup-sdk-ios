@class LUAPIRequest;
@class LUApnDevice;

@interface LUApnDeviceRequest : NSObject

+ (LUAPIRequest *)createApnDevice:(LUApnDevice *)apnDevice;
+ (LUAPIRequest *)unregisterApnDevice:(LUApnDevice *)apnDevice;

@end
