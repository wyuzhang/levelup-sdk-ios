/**
 `LUApnDeviceRequestBuilder` is used to build requests for APN (Apple Push Notification) device tokens. If the app is
 going to handle push notifications, the device token must be registered with LevelUp, and unregistered if
 necessary. See the documentation for `LUApnDevice` for more information.
 */
extern NSString * const DeviceTokenKey;

@class LUApnDevice;
@class LUAPIRequest;

@interface LUApnDeviceRequestBuilder : NSObject

/**
 Builds a request to register an APN device with LevelUp.

 This method will also securely store the device token, so that it can be unregistered later.

 On success, this request will return the registered `LUApnDevice`.

 @param apnDevice An LUApnDevice containing the device token to register. The `token` property of this device must be
 set, while other `LUApnDevice` properties are optional.
 */
+ (LUAPIRequest *)requestToRegisterApnDevice:(LUApnDevice *)apnDevice;

/**
 Builds a request to unregister the current device token.
 
 This token will have been set by a previous call to `requestToRegisterApnDevice:`.

 On success, this request will return the unregistered `LUApnDevice`.
 */
 + (LUAPIRequest *)requestToUnregisterCurrentApnDevice;

@end
