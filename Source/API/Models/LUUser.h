// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

typedef NS_ENUM(NSInteger, LUGender) {
  LUGenderUnspecified,
  LUGenderMale,
  LUGenderFemale
};

@class LUMonetaryValue;

/**
 `LUUser` is a representation of a user in the LevelUp system.
 */
@interface LUUser : LUAPIModel

/**
 The user's birthday.
 */
@property (nonatomic, copy) NSDate *birthdate;

/**
 The ID of the user's current cause, if they have selected one.
 */
@property (nonatomic, copy, readonly) NSNumber *causeID;

/**
 An arbitrary `NSMutableDictionary` of custom attributes. This may be used to store app-specific user information.
 */
@property (nonatomic, strong) NSMutableDictionary *customAttributes;

/**
 The user's email address.
 */
@property (nonatomic, copy) NSString *email;

/**
 The user's first name.
 */
@property (nonatomic, copy) NSString *firstName;

/**
 The user's gender. Maybe set to `LUGenderMale`, `LUGenderFemale` or `LUGenderUnspecified`.
 */
@property (nonatomic, assign) LUGender gender;

/**
 The amount of the user's global credit: that is, credit that can be used at any merchant.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *globalCredit;

/**
 The user's last name.
 */
@property (nonatomic, copy) NSString *lastName;

/**
 The total number of merchants at which the user has made an order.
 */
@property (nonatomic, copy, readonly) NSNumber *merchantsVisitedCount;

/**
 The total number of orders that the user has made on LevelUp.
 */
@property (nonatomic, copy, readonly) NSNumber *ordersCount;

/**
 The user's password. This is only used to set a password; it will always be nil when returned by the server.
 */
@property (nonatomic, copy) NSString *password;

/**
 Specifies if the user has accepted the LevelUp Terms & Conditions.
 */
@property (nonatomic, assign) BOOL termsAccepted;

/**
 The total amount of money that the user has saved using LevelUp.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *totalSavings;

/**
 The unique identifier for this user.
 */
@property (nonatomic, copy, readonly) NSNumber *userID;

/**
 Returns an enumerated value representing a gender.
 @param genderString The string representation of the gender. This string is case insensitive.
 */
+ (LUGender)genderForGenderString:(NSString *)genderString;

/**
 Returns a string representation of the gender for display. The return string will be capitalized (Male, Female).
 @param gender The enumerated value for the gender.
 */
+ (NSString *)genderStringForGender:(LUGender)gender;

- (id)initWithBirthdate:(NSDate *)birthdate causeID:(NSNumber *)causeID connectedToFacebook:(BOOL)connectedToFacebook
       customAttributes:(NSDictionary *)customAttributes email:(NSString *)email firstName:(NSString *)firstName
                 gender:(LUGender)gender globalCredit:(LUMonetaryValue *)globalCredit lastName:(NSString *)lastName
    merchantsVisitedCount:(NSNumber *)merchangsVisitedCount ordersCount:(NSNumber *)ordersCount
          termsAccepted:(BOOL)termsAccepted totalSavings:(LUMonetaryValue *)totalSavings userID:(NSNumber *)userID;

@end
