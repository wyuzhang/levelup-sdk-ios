@class LUAPIStub;
@class LUCauseAffiliation;
@class LUUser;

@interface LUAPIStubFactory : NSObject

+ (LUAPIStub *)stubToClaimLegacyLoyaltyWithID:(NSString *)loyaltyID campaignID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToCreateClaimForCohortCode:(NSString *)code;
+ (LUAPIStub *)stubToCreateCreditCardWithNumber:(NSString *)number
                                            cvv:(NSString *)cvv
                                expirationMonth:(NSNumber *)expirationMonth
                                 expirationYear:(NSNumber *)expirationYear
                                     postalCode:(NSString *)postalCode;
+ (LUAPIStub *)stubToCreateGlobalClaimForCohortCode:(NSString *)code;
+ (LUAPIStub *)stubToCreateTicket:(NSString *)body;
+ (LUAPIStub *)stubToCreateUserWithFacebookAccessToken:(NSString *)facebookAccessToken;
+ (LUAPIStub *)stubToCreateUserWithFirstName:(NSString *)firstName
                                    lastName:(NSString *)lastName
                                       email:(NSString *)email
                                    password:(NSString *)password;
+ (LUAPIStub *)stubToDeleteCreditCardWithID:(NSNumber *)creditCardID;
+ (LUAPIStub *)stubToFacebookConnectWithFacebookAccessToken:(NSString *)facebookAccessToken;
+ (LUAPIStub *)stubToFacebookDisconnect;
+ (LUAPIStub *)stubToGetCampaignWithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetCategories;
+ (LUAPIStub *)stubToGetCohort:(NSString *)code;
+ (LUAPIStub *)stubToGetCohortNotFound:(NSString *)code;
+ (LUAPIStub *)stubToGetCreditCardsOneResult;
+ (LUAPIStub *)stubToGetCreditCardsTwoResults;
+ (LUAPIStub *)stubToGetCurrentUser;
+ (LUAPIStub *)stubToGetLocationSummariesFirstPage;
+ (LUAPIStub *)stubToGetLocationSummariesLastPage;
+ (LUAPIStub *)stubToGetLocationsWithMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetLoyaltyForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetLoyaltyNoCreditForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetNewUser;
+ (LUAPIStub *)stubToGetOrderWithID:(NSNumber *)orderID;
+ (LUAPIStub *)stubToGetOrdersOnPage:(NSNumber *)page;
+ (LUAPIStub *)stubToGetOrdersWithMerchantID:(NSNumber *)merchantID page:(NSNumber *)page;
+ (LUAPIStub *)stubToGetPaymentToken;
+ (LUAPIStub *)stubToLogInWithEmail:(NSString *)email password:(NSString *)password;
+ (LUAPIStub *)stubToLogInWithFacebookAccessToken:(NSString *)facebookAccessToken;
+ (LUAPIStub *)stubToPromoteCreditCardWithID:(NSNumber *)creditCardID;
+ (LUAPIStub *)stubToResetPasswordRequest;
+ (LUAPIStub *)stubToSetCauseAffiliation:(LUCauseAffiliation *)causeAffiliation;
+ (LUAPIStub *)stubToUpdateAdditionalInfoWithFirstName:(NSString *)firstName
                                              lastName:(NSString *)lastName
                                                 email:(NSString *)email
                                                gender:(NSString *)gender
                                              birthday:(NSDate *)birthday __attribute__((deprecated));
+ (LUAPIStub *)stubToUpdateProfileWithFirstName:(NSString *)firstName
                                       lastName:(NSString *)lastName
                                          email:(NSString *)email
                                    newPassword:(NSString *)newPassword
                                       birthday:(NSDate *)birthday
                                         gender:(NSString *)gender __attribute__((deprecated));
+ (LUAPIStub *)stubToUpdateUser:(LUUser *)user;

@end
