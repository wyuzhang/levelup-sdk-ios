#import <Foundation/Foundation.h>

@class LUAPIRequest;
@class LUUser;

@interface LUUserRequest : NSObject

+ (LUAPIRequest *)connectToFacebookWithAccessToken:(NSString *)facebookAccessToken;
+ (LUAPIRequest *)createUser:(LUUser *)user;
+ (LUAPIRequest *)disconnectFromFacebook;
+ (LUAPIRequest *)getCurrentUser;
+ (LUAPIRequest *)removeCauseAffiliation;
+ (LUAPIRequest *)resetPasswordWithEmail:(NSString *)email;
+ (LUAPIRequest *)setCauseId:(NSNumber *)causeId;
+ (LUAPIRequest *)updateUser:(LUUser *)user;

@end
