// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

/**
 This action is used for interstitials that present the user with options to share via email,
 Facebook or Twitter. The message properties are default text that can be used to pre-fill share
 dialogs -- the user can change the text if they wish.
 */
@interface LUInterstitialShareAction : LUAPIModel

/**
 A suggested initial email body to use when a user shares this campaign over email.
 */
@property (nonatomic, copy, readonly) NSString *messageForEmailBody;

/**
 A suggested initial email subject to use when a user shares this campaign over email.
 */
@property (nonatomic, copy, readonly) NSString *messageForEmailSubject;

/**
 A suggested initial post to use when a user shares this campaign over Facebook.
 */
@property (nonatomic, copy, readonly) NSString *messageForFacebook;

/**
 A suggested initial post to use when a user shares this campaign over Twitter.
 */
@property (nonatomic, copy, readonly) NSString *messageForTwitter;

/**
 The URL to use when sharing this campaign via email. Note that this will be included in the email
 body by the server, so it does not need to be added to the email body.
 */
@property (nonatomic, copy, readonly) NSURL *shareURLEmail;

/**
 The URL to use when sharing this campaign via Facebook.
 */
@property (nonatomic, copy, readonly) NSURL *shareURLFacebook;

/**
 The URL to use when sharing this campaign via Twitter.
 */
@property (nonatomic, copy, readonly) NSURL *shareURLTwitter;

- (id)initWithMessageForEmailBody:(NSString *)messageForEmailBody
           messageForEmailSubject:(NSString *)messageForEmailSubject
               messageForFacebook:(NSString *)messageForFacebook
                messageForTwitter:(NSString *)messageForTwitter
                    shareURLEmail:(NSURL *)shareURLEmail
                 shareURLFacebook:(NSURL *)shareURLFacebook
                  shareURLTwitter:(NSURL *)shareURLTwitter;

@end
