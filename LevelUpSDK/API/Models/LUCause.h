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

- (id)initWithCauseID:(NSNumber *)causeID descriptionHTML:(NSString *)descriptionHTML
     employerRequired:(BOOL)employerRequired facebookURL:(NSURL *)facebookURL featured:(BOOL)featured
  homeAddressRequired:(BOOL)homeAddressRequired imageURL_1x:(NSURL *)imageURL_1x
          imageURL_2x:(NSURL *)imageURL_2x minimumAgeRequired:(NSNumber *)minimumAgeRequired
                 name:(NSString *)name partnerSpecificTerms:(NSString *)partnerSpecificTerms
      twitterUsername:(NSString *)twitterUsername websiteURL:(NSURL *)websiteURL;

///-------------------------------
/// @name Attributes
///-------------------------------

/**
 The unique identifier for this cause.
 */
@property (nonatomic, copy, readonly) NSNumber *causeID;

/**
 An HTML description of the cause.
 */
@property (nonatomic, copy, readonly) NSString *descriptionHTML;

/**
 An optional Facebook URL for the cause.
 */
@property (nonatomic, copy, readonly) NSURL *facebookURL;

/**
 Specifies that the cause is "featured". Featured causes may be given extra emphasis to users.
 */
@property (nonatomic, assign, readonly) BOOL featured;

/**
 The name of the cause.
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 An optional Twitter username for the cause.
 */
@property (nonatomic, copy, readonly) NSString *twitterUsername;

/**
 An optional website for the cause.
 */
@property (nonatomic, copy, readonly) NSURL *websiteURL;

/**
 An associated image for the cause. Will automatically return a retina or non-retina scaled image based on the
 screen scale of the device. The resolution is 320x212.
 */
- (NSURL *)imageURL;

/**
 If the cause has a Twitter username, returns a Twitter URL for that username.
 */
- (NSURL *)twitterURL;

///-------------------------------
/// @name Requirements
///-------------------------------

/**
 Specifies that the cause requires the user to provide the name of their employer.
 */
@property (nonatomic, assign, readonly) BOOL employerRequired;

/**
 Specifies whether the user is required to provide a home address before choosing the cause.
 */
@property (nonatomic, assign, readonly) BOOL homeAddressRequired;

/**
 Specifies a minimum age that the user must be over in order to choose the cause.
 */
@property (nonatomic, copy, readonly) NSNumber *minimumAgeRequired;

/**
 Optional terms to which the user must agree before choosing the cause.
 */
@property (nonatomic, copy, readonly) NSString *partnerSpecificTerms;

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
