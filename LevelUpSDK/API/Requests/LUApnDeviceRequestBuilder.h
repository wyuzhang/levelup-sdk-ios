extern NSString * const DeviceTokenKey;

@class LUApnDevice;
@class LUAPIRequest;

@interface LUApnDeviceRequestBuilder : NSObject

+ (LUAPIRequest *)requestToRegisterApnDevice:(LUApnDevice *)apnDevice;
+ (LUAPIRequest *)requestToUnregisterCurrentApnDevice;

@end
