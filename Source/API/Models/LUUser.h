#import "LUAPIModel.h"

/**
 `LUUser` is a representation of a user in the LevelUp system.
 */
typedef NS_ENUM(NSInteger, LUGender) {
  LUGenderUnspecified,
  LUGenderMale,
  LUGenderFemale
};

@class LUMonetaryValue;
@class LUUserAddress;

@interface LUUser : LUAPIModel

/**
 Specifies if the user is allowed to refer other users. The server may set this to NO if the user
 has attempted to abuse the system.
 */
@property (nonatomic, assign, readonly) BOOL ableToRefer;

/**
 The user's birthday.
 */
@property (nonatomic, copy) NSDate *birthdate;

/**
 Specifies if the user has connected to Facebook.
 */
@property (nonatomic, assign, readonly) BOOL connectedToFacebook;

/**
 The amount of the user's global credit: that is, credit that can be used at any merchant.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *credit;

/**
 An arbitrary `NSDictionary` of custom attributes. This may be used to store app-specific user
 information.
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
 The user's gender. Maybe set to `LUGenderMale`, `LUGenderFemale` or `LUGenderUnspecified`.
 */
@property (nonatomic, assign) LUGender gender;

/**
 The user's last name.
 */
@property (nonatomic, copy) NSString *lastName;

/**
 The total amount of money that the user has saved using LevelUp.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *loyaltiesSavings;

/**
 The total number of merchants at which the user has made an order.
 */
@property (nonatomic, copy, readonly) NSNumber *merchantsVisitedCount;

/**
 A new password for the user. This will always be nil when returned by the server; to set a new
 password, `newPassword` and `newPasswordConfirmation` must both be set to the same non-empty value.
 */
@property (nonatomic, copy, getter = theNewPassword) NSString *newPassword;

/**
 New password confirmation. Must match `newPassword` in order for a new password to be successfully
 updated.
 */
@property (nonatomic, copy, getter = theNewPasswordConfirmation) NSString *newPasswordConfirmation;

/**
 The total number of orders that the user has made on LevelUp.
 */
@property (nonatomic, copy, readonly) NSNumber *ordersCount;

/**
 Specifies that the user has at least one active credit card and therefore is able to pay.
 */
@property (nonatomic, assign, readonly) BOOL paymentEligible;

/**
 The user's payment token (typically shown in an app as a QR code).
 */
@property (nonatomic, copy, readonly) NSString *paymentToken;

/**
 An optional promotion code that the user may specify when signing up for a new account.
 */
@property (nonatomic, copy) NSString *promotionCode;

/**
 The time at which the user accepted the LevelUp Terms & Conditions.
 */
@property (nonatomic, copy) NSDate *termsAcceptedDate;

/**
 An array of `LUUserAddress` objects representing the user's addresses (home, work, etc.).
 */
@property (nonatomic, copy) NSArray *userAddresses;

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy, readonly) NSNumber *userID;

- (id)initWithAbleToRefer:(BOOL)ableToRefer birthdate:(NSDate *)birthdate
      connectedToFacebook:(BOOL)connectedToFacebook credit:(LUMonetaryValue *)credit
         customAttributes:(NSDictionary *)customAttributes email:(NSString *)email
                 employer:(NSString *)employer firstName:(NSString *)firstName gender:(LUGender)gender
                 lastName:(NSString *)lastName loyaltiesSavings:(LUMonetaryValue *)loyaltiesSavings
    merchantsVisitedCount:(NSNumber *)merchangsVisitedCount ordersCount:(NSNumber *)ordersCount
          paymentEligible:(BOOL)paymentEligible paymentToken:(NSString *)paymentToken
        termsAcceptedDate:(NSDate *)termsAcceptedDate userAddresses:(NSArray *)userAddresses
                   userID:(NSNumber *)userID;

/**
 The user's home address.
 */
- (LUUserAddress *)homeAddress;

@end
