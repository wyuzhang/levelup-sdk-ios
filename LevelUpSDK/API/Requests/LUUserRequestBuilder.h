@class LUAPIRequest;
@class LUUser;

@interface LUUserRequestBuilder : NSObject

+ (LUAPIRequest *)requestForCurrentUser;
+ (LUAPIRequest *)requestToConnectToFacebookWithAccessToken:(NSString *)facebookAccessToken;
+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user;
+ (LUAPIRequest *)requestToDisconnectFromFacebook;
+ (LUAPIRequest *)requestToRemoveCauseAffiliation;
+ (LUAPIRequest *)requestToResetPasswordWithEmail:(NSString *)email;
+ (LUAPIRequest *)requestToSetCauseId:(NSNumber *)causeId;
+ (LUAPIRequest *)requestToUpdateUser:(LUUser *)user;

@end
