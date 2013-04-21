#import "LUAPIModel.h"

/**
 `LUApnDevice` is used to store an Apple Push Notification device token.

 When an iOS app registers for push notifications, `application:didRegisterForRemoteNotificationsWithDeviceToken:`
 will be called on the application delegate. This device token needs to be registered with the LevelUp servers so that
 push notification can be delivered after an order is made.

 ## Best Practices

 As [described by Apple] [1] the process for registering for remote notifications is to first call
 `registerForRemoteNotificationTypes:`. Then the app delegate will receive
 `application:didRegisterForRemoteNotificationsWithDeviceToken:`. The device token will be passed to this method. Apple
 recommends that an application should register every time it launches.

 Any time a device token is registered, it should be sent to LevelUp via the SDK. Create an `LUApnDevice` instance,
 and use `LUApnDeviceRequestFactory` to issue a request to the API.

   [1]: http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/IPhoneOSClientImp/IPhoneOSClientImp.html#//apple_ref/doc/uid/TP40008194-CH103-SW1
 */

@interface LUApnDevice : LUAPIModel

/**
 The unique identifier for this APN device.
 */
@property (nonatomic, copy) NSNumber *apnDeviceID;

/**
 Specifies whether notifications should be sent to this device in development mode (which uses Apple's sandbox
 notification server) or production (which uses Apple's production notification server). Typically this would match
 `LUAPIClient`'s development mode.
 */
@property (nonatomic, assign) BOOL development;

/**
 The user's location can optionally be associated with an APN device. This property sets the latitude.
 */
@property (nonatomic, copy) NSNumber *lat;

/**
 The user's location can optionally be associated with an APN device. This property sets the longitude.
 */
@property (nonatomic, copy) NSNumber *lng;

/**
 An APN device token. This token is passed into `application:didRegisterForRemoteNotificationsWithDeviceToken:` which
 is called on the application delegate.
 */
@property (nonatomic, copy) NSData *token;

@end
