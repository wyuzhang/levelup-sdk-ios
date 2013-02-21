#import "LUAPIModel.h"

/**
 `LUUser` is a representation of a user in the LevelUp system.
 */
typedef NS_ENUM(NSInteger, LUGender) {
  LUGenderNone,
  LUGenderMale,
  LUGenderFemale
};

@class LUCause;
@class LUMonetaryValue;
@class LUUserAddress;

@interface LUUser : LUAPIModel

/**
 Specifies if the user is allowed to refer other users. The server may set this to NO if the user has attempted to abuse
 the system.
 */
@property (nonatomic, assign) BOOL ableToRefer;

/**
 The user's birthday.
 */
@property (nonatomic, copy) NSDate *birthday;

/**
 A optional cause chosen by the user to which they would like to donate a percentage of their savings. The percent is
 set in `percentDonation`.
 */
@property (nonatomic, strong) LUCause *cause;

/**
 The ID of the user's `cause`.
 */
@property (nonatomic, copy) NSNumber *causeId;

/**
 Specifies if the user has connected to Facebook.
 */
@property (nonatomic, assign) BOOL connectedToFacebook;

/**
 The amount of the user's global credit: that is, credit that can be used at any merchant.
 */
@property (nonatomic, strong) LUMonetaryValue *credit;

/**
 An arbitrary `NSDictionary` of custom attributes. This may be used to store app-specific user information.
 */
@property (nonatomic, copy) NSDictionary *customAttributes;

/**
 The user's email address.
 */
@property (nonatomic, copy) NSString *email;

/**
 The user's employer.
 */
@property (nonatomic, copy) NSString *employer;

/**
 The user's first name.
 */
@property (nonatomic, copy) NSString *firstName;

/**
 The user's gender. Maybe set to `LUGenderMale`, `LUGenderFemale` or `LUGenderNone`.
 */
@property (nonatomic, assign) LUGender gender;

/**
 The user's last name.
 */
@property (nonatomic, copy) NSString *lastName;

/**
 The total amount of money that the user has saved using LevelUp.
 */
@property (nonatomic, strong) LUMonetaryValue *loyaltiesSavings;

/**
 The total number of merchants at which the user has made an order.
 */
@property (nonatomic, copy) NSNumber *merchantsVisitedCount;

/**
 A new password for the user. This will always be nil when returned by the server; to set a new password, `newPassword`
 and `newPasswordConfirmation` must both be set to the same non-empty value.
 */
@property (nonatomic, copy, getter = theNewPassword) NSString *newPassword;

/**
 New password confirmation. Must match `newPassword` in order for a new password to be successfully updated.
 */
@property (nonatomic, copy, getter = theNewPasswordConfirmation) NSString *newPasswordConfirmation;

/**
 The total number of orders that the user has made on LevelUp.
 */
@property (nonatomic, copy) NSNumber *ordersCount;

/**
 Specifies that the user has at least one active credit card and therefore is able to pay.
 */
@property (nonatomic, assign) BOOL paymentEligible;

/**
 The user's payment token (typically shown in an app as a QR code).
 */
@property (nonatomic, copy) NSString *paymentToken;

/**
 The percent of savings that the user would like to donate to their chosen `cause`.
 */
@property (nonatomic, copy) NSNumber *percentDonation;

/**
 An optional promotion code that the user may specify when signing up for a new account.
 */
@property (nonatomic, copy) NSString *promotionCode;

/**
 The user's referral code. Associated with a "Refer-a-Friend" campaign. See the documentation for `LUCampaign` for
 more information.
 */
@property (nonatomic, copy) NSString *referralCode;

/**
 The time at which the user accepted the LevelUp Terms & Conditions.
 */
@property (nonatomic, copy) NSDate *termsAcceptedAt;

/**
 An array of `LUUserAddress` objects representing the user's addresses (home, work, etc.).
 */
@property (nonatomic, copy) NSArray *userAddresses;

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy) NSNumber *userID;

/**
 The user's home address.
 */
- (LUUserAddress *)homeAddress;

/**
 The user's referral URL. When users invite friends to join LevelUp, this URL should be shared.
 */
- (NSString *)referralURL;

@end
