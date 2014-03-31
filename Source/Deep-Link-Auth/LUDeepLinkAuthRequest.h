// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

extern NSString * const LUDeepLinkAuthAppIDURLParam;
extern NSString * const LUDeepLinkAuthOneTimePadURLParam;
extern NSString * const LUDeepLinkAuthPermissionsURLParam;
extern NSString * const LUDeepLinkAuthReturnURLSchemeURLParam;

@class LUOneTimePad;

@interface LUDeepLinkAuthRequest : NSObject

@property (nonatomic, copy, readonly) NSString *appID;
@property (nonatomic, strong, readonly) LUOneTimePad *oneTimePad;
@property (nonatomic, copy, readonly) NSArray *permissions;
@property (nonatomic, copy, readonly) NSString *returnURLScheme;

- (id)initWithAppID:(NSString *)appID oneTimePad:(LUOneTimePad *)oneTimePad
        permissions:(NSArray *)permissions returnURLScheme:(NSString *)returnURLScheme;
- (id)initWithURL:(NSURL *)URL;
+ (instancetype)requestWithPermissions:(NSArray *)permissions
                       returnURLScheme:(NSString *)returnURLScheme;

- (NSURL *)URL;
- (NSError *)validateProperties;
- (NSError *)validateURL;

@end
