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
 Specifies whether the campaign has been claimed by the current user.
 */
@property (nonatomic, assign) BOOL claimed;

/**
 If the campaign is Refer-a-Friend, the cohort for the current user.
 */
@property (nonatomic, strong) LUCohort *cohort;

/**
 The campaign's cohorts.
 */
@property (nonatomic, copy) NSArray *cohorts;

/**
 An HTML message to show the user after claiming the campaign.
 */
@property (nonatomic, copy) NSString *confirmationHtml;

/**
 Specifies if this campaign is marked as global (valid for all merchants).
 */
@property (nonatomic, assign) BOOL global;

/**
 The merchants associated with this campaign. If a campaign is global, this will be empty, since a global campaign
 is valid for all merchants.
 */
@property (nonatomic, copy) NSArray *merchants;

/**
 The name of the campaign.
 */
@property (nonatomic, copy) NSString *name;

/**
 An HTML message describing the campaign.
 */
@property (nonatomic, copy) NSString *offerHtml;

/**
 The campaign's sponsor.
 */
@property (nonatomic, copy) NSString *sponsor;

/**
 An email address to which support inquiries should be sent.
 */
@property (nonatomic, copy) NSString *supportEmail;

/**
 The monetary value of the campaign. This is the amount of credit the user will receive after claiming.
 */
@property (nonatomic, strong) LUMonetaryValue *value;

/**
 A helper method which returns `confirmationHtml` stripped of HTML tags.
 */
- (NSString *)confirmationText;

/**
 Returns an email cohort for the campaign, if one exists.
 */
- (LUCohort *)emailCohort;

/**
 Returns a Facebook cohort for the campaign, if one exists.
 */
- (LUCohort *)facebookCohort;

/**
 Specifies that the campaign is global -- if a user claims it, they will receive global credit that can be used at any
 LevelUp merchant.
 */
- (BOOL)isGlobal;

/**
 An associated mobile image for the campaign. Will automatically return a retina or non-retina scaled image based on the
 screen scale of the device.
 */
- (NSString *)mobileImageUrl;

/**
 A helper method which returns the `offerHtml` stripped of HTML tags.
 */
- (NSString *)offerText;

/**
 Returns `confirmationHtml` if available, or else `offerHtml`.
 */
- (NSString *)successfulClaimMessageHtml;

/**
 Returns `confirmationText` if available, or else `offerText`.
 */
- (NSString *)successfulClaimMessageText;

/**
 Returns a Twitter cohort for the campaign, if one exists.
 */
- (LUCohort *)twitterCohort;

@end
