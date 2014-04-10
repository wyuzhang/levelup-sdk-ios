// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

typedef NS_ENUM(NSInteger, LUInterstitialActionType) {
  LUInterstitialActionTypeUnknown,
  LUInterstitialActionTypeNone,
  LUInterstitialActionTypeClaim,
  LUInterstitialActionTypeFeedback,
  LUInterstitialActionTypeShare,
  LUInterstitialActionTypeURL
};

/**
 An order may be associated with an `LUInterstital`, which represents an interstitial view that can be shown to the
 user. Interstitials can be used for things like showing additional information to the user, prompting them to share
 information about the merchant, or claiming a campaign.

 An interstitial may optionally have an action for the user to complete. There are several possible actions:

 - None: There is no action for the user. In this case the interstitial can be used just for sharing information.
 - Claim: The user will be asked to claim a campaign.
 - Feedback: The user will be asked to rate their experience and provide comments.
 - Share: The user can share information related to the order via email, Facebook or Twitter.
 - URL: The interstitial will include a URL that the user can view.
 - Unknown: A catch-all for any unrecognized types. An interstitial of this type shouldn't be shown to the user.

 The `action` property of `LUInterstitialAction` will contain additional properties relevant to the particular type.
 It may be `nil` (if the action type is "none" or "unknown"), or it may be an instance of `LUInterstitialClaimAction`,
 `LUInterstitialFeedbackAction`, `LUInterstitialShareAction`, or `LUInterstitialURLAction`.
 */
@interface LUInterstitial : LUAPIModel

/**
 An object with information about the action that this interstitial is requesting from the user.

 The type of this property depends on the value of the `actionType` property:

 - `LUInterstitialActionTypeUnknown`: This property will be `nil`.
 - `LUInterstitialActionTypeNone`: This property will be `nil`.
 - `LUInterstitialActionTypeClaim`: This property will be an instance of `LUInterstitialClaimAction`.
 - `LUInterstitialActionTypeFeedback`: This property will be an instance of `LUInterstitialFeedbackAction`.
 - `LUInterstitialActionTypeShare`: This property will be an instance of `LUInterstitialShareAction`.
 - `LUInterstitialActionTypeURL`: This property will be an instance of `LUInterstitialURLAction`.
 */
@property (nonatomic, strong, readonly) id action;

/**
 The type of action this interstitial is requesting.

 Will be one of: `LUInterstitialActionTypeUnknown`, `LUInterstitialActionTypeNone`,
 `LUInterstitialActionTypeClaim`, `LUInterstitialActionTypeFeedback`, `LUInterstitialActionTypeShare`,
 or `LUInterstitialActionTypeURL`.
 */
@property (nonatomic, assign, readonly) LUInterstitialActionType actionType;

/**
 The callout text for the interstitial.
 */
@property (nonatomic, copy, readonly) NSString *calloutText;

/**
 An HTML description of the interstitial.
 */
@property (nonatomic, copy, readonly) NSString *descriptionHTML;

/**
 An image for this interstitial. Will automatically return a retina or non-retina scaled image based on the screen scale
 of the device. The resolution is 320x212.
 */
@property (nonatomic, strong, readonly) NSURL *imageURL;

/**
 The title of the interstitial.
 */
@property (nonatomic, copy, readonly) NSString *title;

- (id)initWithAction:(id)action actionType:(LUInterstitialActionType)actionType calloutText:(NSString *)calloutText
     descriptionHTML:(NSString *)descriptionHTML imageURL:(NSURL *)imageURL title:(NSString *)title;

/**
 A helper method which returns the `descriptionHTML` stripped of HTML tags.
 */
- (NSString *)descriptionText;

@end
