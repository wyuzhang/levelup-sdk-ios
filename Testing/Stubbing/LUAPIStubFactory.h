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
@class LUOrderAheadOrder;
@class LUPaymentPreference;
@class LUUser;
@class LUUserAddress;

@interface LUAPIStubFactory : NSObject

+ (LUAPIStub *)stubForImageAtURL:(NSURL *)URL responseResource:(NSString *)resource;
+ (LUAPIStub *)stubForImageAtURL:(NSURL *)URL responseResource:(NSString *)resource imageType:(NSString *)type;
+ (LUAPIStub *)stubForOrderAheadMenuItemMediumImageAtURLPath:(NSString *)path;
+ (LUAPIStub *)stubForOrderAheadMenuItemSmallImageAtURLPath:(NSString *)path;
+ (LUAPIStub *)stubToClaimCampaignWithCode:(NSString *)code;
+ (LUAPIStub *)stubToClaimLegacyLoyaltyWithID:(NSString *)loyaltyID campaignID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToCompleteOrderAheadOrderWithURL:(NSURL *)URL;
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
+ (LUAPIStub *)stubToCreateUserAddress;
+ (LUAPIStub *)stubToCreateUserAddress:(LUUserAddress *)userAddresss;
+ (LUAPIStub *)stubToCreateUserDebitOnly:(LUUser *)user;
+ (LUAPIStub *)stubToDeactivatePaymentMethod;
+ (LUAPIStub *)stubToDeleteCreditCardWithID:(NSNumber *)creditCardID;
+ (LUAPIStub *)stubToDownloadPass;
+ (LUAPIStub *)stubToFailToClaimCampaignWithCode:(NSString *)code;
+ (LUAPIStub *)stubToFailToCreateCreditCardWithDebitOnlyError;
+ (LUAPIStub *)stubToFailToFindRegistrationForEmail:(NSString *)email;
+ (LUAPIStub *)stubToFailToGetCarrierAccountEVURL;
+ (LUAPIStub *)stubToFailToGetPassWithMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToFailToStartUpdateOfOrderAheadOrder:(LUOrderAheadOrder *)order;
+ (LUAPIStub *)stubToFailToStartUpdateOfOrderAheadOrderWithInvalidCart:(LUOrderAheadOrder *)order;
+ (LUAPIStub *)stubToFindRegistrationForEmail:(NSString *)email;
+ (LUAPIStub *)stubToGetApplePayCardPaymentMethod;
+ (LUAPIStub *)stubToGetApplePayCardPreloadingPaymentMethod;
+ (LUAPIStub *)stubToGetCampaignForMerchantWithCode:(NSString *)code;
+ (LUAPIStub *)stubToGetCampaignMetadataForLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetCampaignMetadataForMerchantWithID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetCampaignRepresentationBasicV1WithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetCampaignRepresentationSpendBasedLoyaltyV1WithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetCampaignRepresentationVisitBasedLoyaltyV1WithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetCampaignWithCode:(NSString *)code;
+ (LUAPIStub *)stubToGetCampaignWithID:(NSNumber *)campaignID;
+ (LUAPIStub *)stubToGetCarrierAccountEVURL;
+ (LUAPIStub *)stubToGetCarrierAccountPaymentMethod;
+ (LUAPIStub *)stubToGetCategories;
+ (LUAPIStub *)stubToGetCreditAtLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetCreditAndDebitCards;
+ (LUAPIStub *)stubToGetCreditCardPaymentMethod;
+ (LUAPIStub *)stubToGetCreditCardPreloadingPaymentMethod;
+ (LUAPIStub *)stubToGetCreditCardsOneResult;
+ (LUAPIStub *)stubToGetCreditCardsTwoResults;
+ (LUAPIStub *)stubToGetCreditCardsThreeResults;
+ (LUAPIStub *)stubToGetCreditCardsThreeResultsIncludingCarrier;
+ (LUAPIStub *)stubToGetCurrentUser;
+ (LUAPIStub *)stubToGetCurrentUserDebitOnly;
+ (LUAPIStub *)stubToGetCurrentUserWithoutOptionalInfo;
+ (LUAPIStub *)stubToGetCurrentUserWithoutOptionalInfoWithDebitOnly;
+ (LUAPIStub *)stubToGetDebitCardPaymentMethod;
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
+ (LUAPIStub *)stubToGetNonePaymentMethod;
+ (LUAPIStub *)stubToGetNoUserAddresses;
+ (LUAPIStub *)stubToGetOrderAheadCompletedDeliveryOrderWithURL:(NSURL *)URL;
+ (LUAPIStub *)stubToGetOrderAheadCompletedOrderWithURL:(NSURL *)URL;
+ (LUAPIStub *)stubToGetOrderAheadCompletedPickupOrderWithURL:(NSURL *)URL;
+ (LUAPIStub *)stubToGetOrderAheadDeliveryLocationWithAddressID:(NSNumber *)addressID;
+ (LUAPIStub *)stubToGetOrderAheadMenuWithURL:(NSURL *)URL;
+ (LUAPIStub *)stubToGetOrderAheadPendingViewableOrderWithURL:(NSURL *)URL;
+ (LUAPIStub *)stubToGetOrderAheadViewableOrderWithURL:(NSURL *)URL;
+ (LUAPIStub *)stubToGetOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToGetOrdersEmpty;
+ (LUAPIStub *)stubToGetOrdersFirstPage;
+ (LUAPIStub *)stubToGetOrdersLastPage;
+ (LUAPIStub *)stubToGetOrdersSecondPage;
+ (LUAPIStub *)stubToGetPassWithMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetPaymentOptionsSummary;
+ (LUAPIStub *)stubToGetPaymentToken;
+ (LUAPIStub *)stubToGetPaymentTokenWithActionAndMessage;
+ (LUAPIStub *)stubToGetPaymentTokenWithMessage;
+ (LUAPIStub *)stubToGetPendingPassWithMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetPendingUpdatedCarrierAccountWithID:(NSNumber *)carrierAccountID;
+ (LUAPIStub *)stubToGetPickupLocationsNearLocation:(CLLocation *)location forMerchantID:(NSNumber *)merchantID;
+ (LUAPIStub *)stubToGetRewardSummaryAtLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetRewardsAtLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToGetSuggestedOrders;
+ (LUAPIStub *)stubToGetSuggestedOrdersForLocationWithID:(NSNumber *)locationID types:(NSArray *)types;
+ (LUAPIStub *)stubToGetUpdatedCarrierAccountWithID:(NSNumber *)carrierAccountID;
+ (LUAPIStub *)stubToGetUserAddresses;
+ (LUAPIStub *)stubToGetURL:(NSString *)url withBody:(NSString *)body;
+ (LUAPIStub *)stubToGetWebLinksAtLocationWithID:(NSNumber *)locationID;
+ (LUAPIStub *)stubToIdentifyCarrierAccount;
+ (LUAPIStub *)stubToLogIn;
+ (LUAPIStub *)stubToLogInWithEmail:(NSString *)email password:(NSString *)password;
+ (LUAPIStub *)stubToPromoteCreditCardWithID:(NSNumber *)creditCardID;
+ (LUAPIStub *)stubToResetPasswordRequest;
+ (LUAPIStub *)stubToSetPaymentPreference;
+ (LUAPIStub *)stubToStartUpdateOfOrderAheadOrder:(LUOrderAheadOrder *)order;
+ (LUAPIStub *)stubToSubmitFeedbackForOrderWithUUID:(NSString *)UUID;
+ (LUAPIStub *)stubToUpdateCarrierAccountWithID:(NSNumber *)carrierAccountID
                             mobileDeviceNumber:(NSString *)mobileDeviceNumber
                                    carrierName:(NSString *)carrierName;
+ (LUAPIStub *)stubToUpdateUser;
+ (LUAPIStub *)stubToUpdateUser:(LUUser *)user;

@end
