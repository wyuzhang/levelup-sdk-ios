#import "LUAPIModel.h"

/**
 LevelUp users can optionally choose a cause (such a charity, for example) to which they would like to donate money.
 Every time they make an order using LevelUp, if they saved money on the order (such as with LevelUp credit), LevelUp
 will automatically donate a percentage of this savings to the cause. This percentage is set using the `percentDonation`
 property of `LUUser`.

 ## Requirements

 Causes may have certain requirements before they can be chosen by a user. These requirements may be any of the
 following:

 - The user must provide their employer.
 - The user must provide their home address.
 - The user must be over a minimum age (specified by the cause).
 - The cause has terms to which the user must agree.
 */
@interface LUCause : LUAPIModel

///-------------------------------
/// @name Attributes
///-------------------------------

/**
 An HTML description of the cause.
 */
@property (nonatomic, copy) NSString *descriptionHtml;

/**
 An optional Facebook URL for the cause.
 */
@property (nonatomic, copy) NSString *facebookUrl;

/**
 Specifies that the cause is "featured". Featured causes may be given extra emphasis to users.
 */
@property (nonatomic, assign) BOOL featured;

/**
 The name of the cause.
 */
@property (nonatomic, copy) NSString *name;

/**
 An optional Twitter username for the cause.
 */
@property (nonatomic, copy) NSString *twitterUsername;

/**
 An optional website for the cause.
 */
@property (nonatomic, copy) NSString *website;

/**
 An associated image for the cause. Will automatically return a retina or non-retina scaled image based on the
 screen scale of the device.
 */
- (NSString *)imageUrl;

/**
 If the cause has a Twitter username, returns a Twitter URL for that username.
 */
- (NSString *)twitterUrl;

///-------------------------------
/// @name Requirements
///-------------------------------

/**
 Specifies that the cause requires the user to provide the name of their employer.
 */
@property (nonatomic, assign) BOOL employerRequired;

/**
 Specifies whether the user is required to provide a home address before choosing the cause.
 */
@property (nonatomic, assign) BOOL homeAddressRequired;

/**
 Specifies a minimum age that the user must be over in order to choose the cause.
 */
@property (nonatomic, copy) NSNumber *minimumAgeRequired;

/**
 Optional terms to which the user must agree before choosing the cause.
 */
@property (nonatomic, copy) NSString *partnerSpecificTerms;

/**
 Specifies if the cause has any requirements on the user before being chosen.
 */
- (BOOL)anyUserRequirements;

/**
 Specifies whether the cause has a minimum age requirement.
 */
- (BOOL)hasMinimumAgeRequired;

/**
 Specifies whether the cause has terms to which the user must agree.
 */
- (BOOL)hasPartnerSpecificTerms;

@end
