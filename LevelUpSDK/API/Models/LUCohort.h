#import "LUAPIModel.h"

/**
 A cohort represents a source through which a user claims a campaign. See the documentation for `LUCampaign` for more
 information.
 */
@class LUCampaign;

@interface LUCohort : LUAPIModel

/**
 The campaign associated with this cohort.
 */
@property (nonatomic, strong) LUCampaign *campaign;

/**
 A unique code associated with this cohort. This code is used when generating QR codes for cohorts.
 */
@property (nonatomic, copy) NSString *code;

/**
 The type of cohort. This can be set to any value a merchant chooses, such as example specific ads or links. Common
 types are 'default_email', 'default_facebook', and 'default_twitter'.
 */
@property (nonatomic, copy) NSString *cohortType;

/**
 A long description of the cohort.
 */
@property (nonatomic, copy) NSString *description;

/**
 A suggested initial email body to use when a user shares this cohort over email.
 */
@property (nonatomic, copy) NSString *emailBody;

/**
 A suggested initial email subject to use when a user shares this cohort over email.
 */
@property (nonatomic, copy) NSString *messageForEmailSubject;

/**
 A suggested initial Twitter post to use when a user shares this cohort over email.
 */
@property (nonatomic, copy) NSString *messageForTwitter;

/**
 A unique URL for the cohort. This URL should be used when users share the cohort.
 */
@property (nonatomic, copy) NSString *url;

@end
