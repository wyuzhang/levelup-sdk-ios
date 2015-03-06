/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

@class LUAPIStub;
@class LUGiftCardOrder;
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
+ (LUAPIStub *)stubToCreateGiftCardOrder:(LUGiftCardOrder *)giftCardOrder;
+ (LUAPIStub *)stubToCreateTicket:(NSString *)body;
+ (LUAPIStub *)stubToCreateUser;
+ (LUAPIStub *)stubToCreateUser:(LUUser *)user;
+ (LUAPIStub *)stubToCreateUser:(LUUser *)user withPermissions:(NSArray *)permissions;
+ (LUAPIStub *)stubToCreateUserDebitOnly:(LUUser *)user;
+ (LUAPIStub *)stubToDeleteCreditCardWithID:(NSNumber *)creditCardID;
+ (LUAPIStub *)stubToDownloadPass;
+ (LUAPIStub *)stubToFailToClaimCampaignWithCode:(NSString *)code;
+ (LUAPIStub *)stubToFailToCreateCreditCardWithDebitOnlyError;
+ (LUAPIStub *)stubToFailToFindRegistrationForEmail:(NSString *)email;
+ (LUAPIStub *)stubToFailToGetCarrierAccountEVURL;
+ (LUAPIStub *)stubToFailToGetPassWithMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToFindRegistrationForEmail:(NSString *)email;
+ (LUAPIStub *)stubToGetCampaignForMerchantWithCode:(NSString *)code;
+ (LUAPIStub *)stubToGetCampaignMetadataForLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetCampaignMetadataForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetCampaignRepresentationBasicV1WithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetCampaignWithCode:(NSString *)code;
+ (LUAPIStub *)stubToGetCampaignWithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetCarrierAccountEVURL;
+ (LUAPIStub *)stubToGetCategories;
+ (LUAPIStub *)stubToGetCreditAtLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetCreditAndDebitCards;
+ (LUAPIStub *)stubToGetCreditCardsOneResult;
+ (LUAPIStub *)stubToGetCreditCardsTwoResults;
+ (LUAPIStub *)stubToGetCreditCardsThreeResults;
+ (LUAPIStub *)stubToGetCreditCardsThreeResultsIncludingCarrier;
+ (LUAPIStub *)stubToGetCurrentUser;
+ (LUAPIStub *)stubToGetCurrentUserDebitOnly;
+ (LUAPIStub *)stubToGetCurrentUserWithoutOptionalInfo;
+ (LUAPIStub *)stubToGetCurrentUserWithoutOptionalInfoWithDebitOnly;
+ (LUAPIStub *)stubToGetDowngradedAccessTokenWithPermissions:(NSArray *)accessTokenPermissions;
+ (LUAPIStub *)stubToGetFeedbackInterstitialForOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToGetIneligiblePaymentToken;
+ (LUAPIStub *)stubToGetIneligiblePaymentTokenExcessiveChargebacks;
+ (LUAPIStub *)stubToGetInterstitialForOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToGetInterstitialNotFoundForOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToGetLocationSummariesFirstPage;
+ (LUAPIStub *)stubToGetLocationSummariesLastPage;
+ (LUAPIStub *)stubToGetLocationsForAppFirstPageNearLocation:(CLLocation *)location;
+ (LUAPIStub *)stubToGetLocationsForAppLastPage;
+ (LUAPIStub *)stubToGetLocationsForMerchantFirstPageNearLocation:(CLLocation *)location forMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetLocationsForMerchantLastPageForMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetLoyaltyDisabledForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetLoyaltyForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetLoyaltyNoCreditForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetMerchantIDs:(NSArray *)merchantIDs forCampaignWithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetNewUser;
+ (LUAPIStub *)stubToGetOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToGetOrdersEmpty;
+ (LUAPIStub *)stubToGetOrdersFirstPage;
+ (LUAPIStub *)stubToGetOrdersLastPage;
+ (LUAPIStub *)stubToGetOrdersSecondPage;
+ (LUAPIStub *)stubToGetPassWithMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetPaymentToken;
+ (LUAPIStub *)stubToGetPaymentTokenWithActionAndMessage;
+ (LUAPIStub *)stubToGetPaymentTokenWithMessage;
+ (LUAPIStub *)stubToGetPendingPassWithMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetPendingUpdatedCarrierAccountWithID:(NSNumber *)carrierAccountID;
+ (LUAPIStub *)stubToGetUpdatedCarrierAccountWithID:(NSNumber *)carrierAccountID;
+ (LUAPIStub *)stubToGetURL:(NSString *)url withBody:(NSString *)body;
+ (LUAPIStub *)stubToGetWebLinksAtLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToIdentifyCarrierAccount;
+ (LUAPIStub *)stubToLogIn;
+ (LUAPIStub *)stubToLogInWithEmail:(NSString *)email password:(NSString *)password;
+ (LUAPIStub *)stubToPromoteCreditCardWithID:(NSNumber *)creditCardID;
+ (LUAPIStub *)stubToResetPasswordRequest;
+ (LUAPIStub *)stubToSubmitFeedbackForOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToUpdateCarrierAccountWithID:(NSNumber *)carrierAccountID
                             mobileDeviceNumber:(NSString *)mobileDeviceNumber
                                    carrierName:(NSString *)carrierName;
+ (LUAPIStub *)stubToUpdateUser;
+ (LUAPIStub *)stubToUpdateUser:(LUUser *)user;

@end
