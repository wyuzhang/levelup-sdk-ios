#import "LUAPIModel.h"

/**
 LevelUp campaigns are general objects used by merchants and advertisers. They are typically used by merchants to
 acquire new customers and/or re-engage new customers.

 ## Campaigns

 Applications built on the LevelUp SDK will usually interact with campaigns in one of several ways:

 - Users may scan QR codes representing a campaign, which will then claim the campaign for them, and show a success
 screen providing more information about the campaign, and ways to share the campaign online.
 - Each users has a unique referral code which they can share with their friends. If someone joins LevelUp using their
 code, both the referring user and the new user will get LevelUp credit. Behind the scenes, these referral programs are
 implemented using "Refer-a-Friend" campaigns.
 - Some merchants support migration of loyalty cards into LevelUp credit. These are handled by "Legacy Loyalty"
 campaigns.

 ## Cohorts

 Users claim campaigns via cohorts, which represents the source of the campaign. This could be an online source (Facebook,
 Twitter, email), a user (in the case of Refer-a-Friend campaigns), or a loyalty card (for loyalty credit migrations).
 */

@class LUCohort;
@class LUMonetaryValue;

@interface LUCampaign : LUAPIModel

/**
 The unique identifier for this campaign.
 */
@property (nonatomic, copy, readonly) NSNumber *campaignID;

/**
 Specifies whether the campaign has been claimed by the current user.
 */
@property (nonatomic, assign, readonly) BOOL claimed;

/**
 The campaign's cohorts.
 */
@property (nonatomic, copy, readonly) NSArray *cohorts;

/**
 An HTML message to show the user after claiming the campaign.
 */
@property (nonatomic, copy, readonly) NSString *confirmationHTML;

/**
 Specifies that the campaign is global -- if a user claims it, they will receive global credit that can be used at any
 LevelUp merchant.
 */
@property (nonatomic, assign, readonly) BOOL global;

/**
 The merchants associated with this campaign. If a campaign is global, this will be empty, since a global campaign
 is valid for all merchants.
 */
@property (nonatomic, copy, readonly) NSArray *merchants;

/**
 The name of the campaign.
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 An HTML message describing the campaign.
 */
@property (nonatomic, copy, readonly) NSString *offerHTML;

/**
 The campaign's sponsor.
 */
@property (nonatomic, copy, readonly) NSString *sponsor;

/**
 An email address to which support inquiries should be sent.
 */
@property (nonatomic, copy, readonly) NSString *supportEmail;

/**
 The monetary value of the campaign. This is the amount of credit the user will receive after claiming.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *value;

- (id)initWithCampaignID:(NSNumber *)campaignID claimed:(BOOL)claimed cohorts:(NSArray *)cohorts
        confirmationHTML:(NSString *)confirmationHTML global:(BOOL)global
             imageURL_1x:(NSURL *)imageURL_1x imageURL_2x:(NSURL *)imageURL_2x
               merchants:(NSArray *)merchants name:(NSString *)name offerHTML:(NSString *)offerHTML
      referAFriendCohort:(LUCohort *)referAFriendCohort sponsor:(NSString *)sponsor
            supportEmail:(NSString *)supportEmail value:(LUMonetaryValue *)value;

/**
 A helper method which returns `confirmationHTML` stripped of HTML tags.
 */
- (NSString *)confirmationText;

/**
 An associated image for the campaign. Will automatically return a retina or non-retina scaled image based on the
 screen scale of the device. The resolution of the image is 320x212.
 */
- (NSURL *)imageURL;

/**
 A helper method which returns the `offerHTML` stripped of HTML tags.
 */
- (NSString *)offerText;

/**
 A suggested initial email body to use when a user shares this campaign over email.
 */
- (NSString *)shareMessageForEmailBody;

/**
 A suggested initial email subject to use when a user shares this campaign over email.
 */
- (NSString *)shareMessageForEmailSubject;

/**
 A suggested initial post to use when a user shares this campaign over Twitter.
 */
- (NSString *)shareMessageForTwitter;

/**
 The URL to use when sharing this campaign via email.
 */
- (NSURL *)shareURLForEmail;

/**
 The URL to use when sharing this campaign via Facebook.
 */
- (NSURL *)shareURLForFacebook;

/**
 The URL to use when sharing this campaign via Twitter.
 */
- (NSURL *)shareURLForTwitter;

@end
