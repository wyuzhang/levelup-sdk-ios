// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

/**
 `LUAPNDeviceRequestFactory` is used to build requests for APN (Apple Push Notification) device tokens. If the app is
 going to handle push notifications, the device token must be registered with LevelUp, and unregistered if
 necessary.

 When an iOS app registers for push notifications, `application:didRegisterForRemoteNotificationsWithDeviceToken:`
 will be called on the application delegate. This device token needs to be registered with the LevelUp servers so that
 push notification can be delivered after an order is made.

 ## Best Practices

 As [described by Apple] [1] the process for registering for remote notifications is to first call
 `registerForRemoteNotificationTypes:`. Then the app delegate will receive
 `application:didRegisterForRemoteNotificationsWithDeviceToken:`. The device token will be passed to this method. Apple
 recommends that an application should register every time it launches.

 Any time a device token is registered, it should be sent to LevelUp via the SDK.

 [1]: http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/IPhoneOSClientImp/IPhoneOSClientImp.html#//apple_ref/doc/uid/TP40008194-CH103-SW1
*/
extern NSString * const LUDeviceTokenKey;

@class LUAPIRequest;

@interface LUAPNDeviceRequestFactory : NSObject

/**
 Builds a request to register an APN device with LevelUp.

 This method will also securely store the device token, so that it can be unregistered later.

 @param deviceToken An APN device token to register.
 @param sandbox Specifies whether notifications should be sent to this device in sandbox mode (which uses Apple's
 sandbox notification server) or production (which uses Apple's production notification server). Typically this would
 match `LUAPIClient`'s development mode.
 */
+ (LUAPIRequest *)requestToRegisterAPNDeviceWithToken:(NSData *)deviceToken sandbox:(BOOL)sandbox;

/**
 Builds a request to unregister the current device token.

 This token will have been set by a previous call to `requestToRegisterAPNDeviceWithToken:sandbox:`.
 */
+ (LUAPIRequest *)requestToUnregisterCurrentAPNDevice;

@end
