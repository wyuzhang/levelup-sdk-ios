// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIStub;
@class LUUser;

@interface LUAPIStubFactory : NSObject

+ (LUAPIStub *)stubToClaimCampaignWithCode:(NSString *)code;
+ (LUAPIStub *)stubToClaimLegacyLoyaltyWithID:(NSString *)loyaltyID campaignID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToCreateCreditCardWithNumber:(NSString *)number
                                            cvv:(NSString *)cvv
                                expirationMonth:(NSNumber *)expirationMonth
                                 expirationYear:(NSNumber *)expirationYear
                                     postalCode:(NSString *)postalCode;
+ (LUAPIStub *)stubToCreateDebitCardWithNumber:(NSString *)number
                                           cvv:(NSString *)cvv
                               expirationMonth:(NSNumber *)expirationMonth
                                expirationYear:(NSNumber *)expirationYear
                                    postalCode:(NSString *)postalCode;
+ (LUAPIStub *)stubToCreateTicket:(NSString *)body;
+ (LUAPIStub *)stubToCreateUser;
+ (LUAPIStub *)stubToCreateUser:(LUUser *)user;
+ (LUAPIStub *)stubToCreateUserDebitOnly:(LUUser *)user;
+ (LUAPIStub *)stubToDeleteCreditCardWithID:(NSNumber *)creditCardID;
+ (LUAPIStub *)stubToFailToClaimCampaignWithCode:(NSString *)code;
+ (LUAPIStub *)stubToFailToCreateCreditCardWithDebitOnlyError;
+ (LUAPIStub *)stubToGetCampaignForMerchantWithCode:(NSString *)code;
+ (LUAPIStub *)stubToGetCampaignWithCode:(NSString *)code;
+ (LUAPIStub *)stubToGetCampaignWithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetCategories;
+ (LUAPIStub *)stubToGetCreditAtLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetCreditAndDebitCards;
+ (LUAPIStub *)stubToGetCreditCardsOneResult;
+ (LUAPIStub *)stubToGetCreditCardsTwoResults;
+ (LUAPIStub *)stubToGetCreditCardsThreeResults;
+ (LUAPIStub *)stubToGetCurrentUser;
+ (LUAPIStub *)stubToGetCurrentUserDebitOnly;
+ (LUAPIStub *)stubToGetCurrentUserWithoutOptionalInfo;
+ (LUAPIStub *)stubToGetCurrentUserWithoutOptionalInfoWithDebitOnly;
+ (LUAPIStub *)stubToGetIneligiblePaymentToken;
+ (LUAPIStub *)stubToGetInterstitialNotFoundForOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToGetInterstitialForOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToGetLocationSummariesFirstPage;
+ (LUAPIStub *)stubToGetLocationSummariesLastPage;
+ (LUAPIStub *)stubToGetLocationsForAppFirstPageNearLocation:(CLLocation *)location;
+ (LUAPIStub *)stubToGetLocationsForAppLastPage;
+ (LUAPIStub *)stubToGetLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetLoyaltyDisabledForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetLoyaltyForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetLoyaltyNoCreditForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetMerchantIDs:(NSArray *)merchantIDs forCampaignWithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetNewUser;
+ (LUAPIStub *)stubToGetOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToGetOrdersFirstPage;
+ (LUAPIStub *)stubToGetOrdersLastPage;
+ (LUAPIStub *)stubToGetOrdersSecondPage;
+ (LUAPIStub *)stubToGetPaymentToken;
+ (LUAPIStub *)stubToGetURL:(NSString *)url withBody:(NSString *)body;
+ (LUAPIStub *)stubToLogIn;
+ (LUAPIStub *)stubToLogInWithEmail:(NSString *)email password:(NSString *)password;
+ (LUAPIStub *)stubToPromoteCreditCardWithID:(NSNumber *)creditCardID;
+ (LUAPIStub *)stubToResetPasswordRequest;
+ (LUAPIStub *)stubToSubmitFeedbackForOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToUpdateUser;
+ (LUAPIStub *)stubToUpdateUser:(LUUser *)user;

@end
