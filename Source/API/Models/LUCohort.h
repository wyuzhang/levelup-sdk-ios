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
@property (nonatomic, strong, readonly) LUCampaign *campaign;

/**
 A unique code associated with this cohort. This code is used when generating QR codes for cohorts.
 */
@property (nonatomic, copy, readonly) NSString *code;

/**
 A long description of the cohort.
 */
@property (nonatomic, copy, readonly) NSString *cohortDescription;

/**
 The unique identifier for this cohort.
 */
@property (nonatomic, copy, readonly) NSNumber *cohortID;

/**
 The type of cohort. This can be set to any value a merchant chooses, such as example specific ads or links. Common
 types are 'default_email', 'default_facebook', and 'default_twitter'.
 */
@property (nonatomic, copy, readonly) NSString *cohortType;

/**
 A unique URL for the cohort. This URL should be used when users share the cohort.
 */
@property (nonatomic, copy, readonly) NSURL *cohortURL;

/**
 A suggested initial email body to use when a user shares this cohort over email.
 */
@property (nonatomic, copy, readonly) NSString *emailBody;

/**
 A suggested initial email subject to use when a user shares this cohort over email.
 */
@property (nonatomic, copy, readonly) NSString *messageForEmailSubject;

/**
 A suggested initial post to use when a user shares this cohort over Twitter.
 */
@property (nonatomic, copy, readonly) NSString *messageForTwitter;

- (id)initWithCampaign:(LUCampaign *)campaign code:(NSString *)code
     cohortDescription:(NSString *)cohortDescription cohortID:(NSNumber *)cohortID
            cohortType:(NSString *)cohortType cohortURL:(NSURL *)cohortURL
             emailBody:(NSString *)emailBody messageForEmailSubject:(NSString *)messageForEmailSubject
     messageForTwitter:(NSString *)messageForTwitter;

@end
