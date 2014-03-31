// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

extern NSString * const LUDeepLinkAuthPaddedAccessTokenURLParam;
extern NSString * const LUDeepLinkAuthPermissionAcceptedURLParam;

@interface LUDeepLinkAuthResponse : NSObject

@property (nonatomic, assign, readonly) BOOL accepted;
@property (nonatomic, copy, readonly) NSString *paddedAccessToken;
@property (nonatomic, copy, readonly) NSString *sourceApplication;

- (id)initWithAccepted:(BOOL)accepted paddedAccessToken:(NSString *)paddedAccessToken
     sourceApplication:(NSString *)sourceApplication;
+ (instancetype)responseWithURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication;

+ (BOOL)isDeepLinkAuthResponseURL:(NSURL *)URL;
+ (NSURL *)responseURLWithScheme:(NSString *)scheme
                        accepted:(BOOL)accepted
               paddedAccessToken:(NSString *)paddedAccessToken;
- (NSString *)decodedAccessToken;
- (NSError *)validate;

@end
