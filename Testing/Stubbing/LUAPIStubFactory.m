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

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAPIStub.h"
#import "LUAPIStubFactory.h"
#import "LUCoreDataStack.h"
#import "LUDeviceIdentifier.h"
#import "LULocationCacheUpdater.h"
#import "LUUser.h"
#import "LUUserParameterBuilder.h"
#import "NSDate+StringFormats.h"

@implementation LUAPIStubFactory

#pragma mark - Public Methods

+ (LUAPIStub *)stubToClaimCampaignWithCode:(NSString *)code {
  NSDictionary *responseJSON = @{
    @"claim" : @{
      @"campaign_id" : @1,
      @"code" : code,
      @"id" : @1,
      @"value_amount" : @5,
      @"value_remaining" : @2
    }
  };

  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:[NSString stringWithFormat:@"codes/%@/claims", code]
                           HTTPMethod:@"POST"
                        authenticated:YES
                         responseData:[self responseDataFromJSON:responseJSON]];
}

+ (LUAPIStub *)stubToClaimLegacyLoyaltyWithID:(NSString *)loyaltyID campaignID:(NSNumber *)campaignID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:[NSString stringWithFormat:@"loyalties/legacy/%@/claims", [campaignID stringValue]]
                           HTTPMethod:@"POST"
                        authenticated:NO
                         responseData:[self responseDataFromFile:@"legacy_loyalty_claim"]];
}

+ (LUAPIStub *)stubToCreateCreditCardWithNumber:(NSString *)number
                                            cvv:(NSString *)cvv
                                expirationMonth:(NSNumber *)expirationMonth
                                 expirationYear:(NSNumber *)expirationYear
                                     postalCode:(NSString *)postalCode {
  return [self stubToCreatePaymentCardWithNumber:number
                                             cvv:cvv
                                 expirationMonth:expirationMonth
                                  expirationYear:expirationYear
                                      postalCode:postalCode
                            responseDataFileName:@"credit_card"];
}

+ (LUAPIStub *)stubToCreateDebitCardWithNumber:(NSString *)number
                                           cvv:(NSString *)cvv
                               expirationMonth:(NSNumber *)expirationMonth
                                expirationYear:(NSNumber *)expirationYear
                                    postalCode:(NSString *)postalCode {
  return [self stubToCreatePaymentCardWithNumber:number
                                             cvv:cvv
                                 expirationMonth:expirationMonth
                                  expirationYear:expirationYear
                                      postalCode:postalCode
                            responseDataFileName:@"debit_card"];
}

+ (LUAPIStub *)stubToCreateTicket:(NSString *)body {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:@"tickets"
                                      HTTPMethod:@"POST"
                                   authenticated:YES
                                    responseData:[self responseDataFromFile:@"ticket"]];
  stub.requestBodyJSON = @{ @"ticket" : @{ @"body" : body } };
  return stub;
}

+ (LUAPIStub *)stubToCreateUser {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                              path:@"users"
                                        HTTPMethod:@"POST"
                                    authenticated:NO
                                      responseData:[self responseDataFromFile:@"current_user"]];
}

+ (LUAPIStub *)stubToCreateUser:(LUUser *)user {
  LUAPIStub *stub = [self stubToCreateUser];

  stub.requestBodyJSON = [self requestBodyJSONForUser:user];
  stub.responseData = [self responseDataFromJSON:[self responseJSONForUser:user]];

  return stub;
}

+ (LUAPIStub *)stubToCreateUser:(LUUser *)user withPermissions:(NSArray *)permissions {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion15
                                            path:@"apps/users"
                                      HTTPMethod:@"POST"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"user_with_access_token"]];

  NSMutableDictionary *requestBodyJSON = [[self requestBodyJSONForUser:user] mutableCopy];
  requestBodyJSON[@"permission_keynames"] = permissions;
  stub.requestBodyJSON = requestBodyJSON;

  return stub;
}

+ (LUAPIStub *)stubToCreateUserDebitOnly:(LUUser *)user {
  LUAPIStub *stub = [self stubToCreateUser];

  NSMutableDictionary *responseJSON = [[self responseJSONForUser:user] mutableCopy];
  responseJSON[@"debit_card_only"] = @(YES);

  stub.requestBodyJSON = [self requestBodyJSONForUser:user];
  stub.responseData = [self responseDataFromJSON:responseJSON];

  return stub;
}

+ (LUAPIStub *)stubToDeleteCreditCardWithID:(NSNumber *)creditCardID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[@"credit_cards/" stringByAppendingString:[creditCardID stringValue]]
                           HTTPMethod:@"DELETE"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"credit_card"]];
}

+ (LUAPIStub *)stubToDownloadPass {
  NSDictionary *passJSON = [NSJSONSerialization JSONObjectWithData:[self responseDataFromFile:@"pass"]
                                                           options:0 error:nil];
  LUAPIStub *stub = [[LUAPIStub alloc] init];
  stub.URL = [NSURL URLWithString:passJSON[@"url"]];
  stub.HTTPMethod = @"GET";

  NSString *responseFile = [[NSBundle bundleForClass:[self class]] pathForResource:@"pass" ofType:@"pkpass"];
  stub.responseData = [NSData dataWithContentsOfFile:responseFile];

  stub.responseHeaders = @{@"Authorization": [@"ApplePass " stringByAppendingString:passJSON[@"authentication_token"]]};

  return stub;
}

+ (LUAPIStub *)stubToFailToClaimCampaignWithCode:(NSString *)code {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion15
                                            path:[NSString stringWithFormat:@"codes/%@/claims", code]
                                      HTTPMethod:@"POST"
                                   authenticated:YES
                                    responseData:[self responseDataFromFile:@"failed_claim"]];
  stub.responseCode = 404;
  return stub;
}

+ (LUAPIStub *)stubToFailToCreateCreditCardWithDebitOnlyError {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion15
                                            path:@"credit_cards"
                                      HTTPMethod:@"POST"
                                   authenticated:YES
                                    responseData:[self responseDataFromFile:@"failed_credit_card_create"]];
  stub.responseCode = 504;
  return stub;
}

+ (LUAPIStub *)stubToFailToFindRegistrationForEmail:(NSString *)email {
  LUAPIStub *stub = [self stubToFindRegistrationForEmail:email];
  stub.responseCode = 404;
  stub.responseData = [self responseDataFromFile:@"failed_registration"];
  return stub;
}

+ (LUAPIStub *)stubToFailToGetPassWithMerchantID:(NSNumber *)merchantID {
  LUAPIStub *stub = [self stubToGetPassWithMerchantID:merchantID];
  stub.responseCode = 404;
  stub.responseData = nil;
  return stub;
}

+ (LUAPIStub *)stubToFindRegistrationForEmail:(NSString *)email {
  NSString *path = [NSString stringWithFormat:@"registration?api_key=%@&email=%@",
                    [LUAPIClient sharedClient].apiKey,
                    [email stringByReplacingOccurrencesOfString:@"@" withString:@"%40"]];

  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:path
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:[self responseDataFromFile:@"registration"]];
}

+ (LUAPIStub *)stubToGetCampaignForMerchantWithCode:(NSString *)code {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[NSString stringWithFormat:@"codes/%@/campaign", code]
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"campaign_nonglobal"]];
}

+ (LUAPIStub *)stubToGetCampaignWithCode:(NSString *)code {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[NSString stringWithFormat:@"codes/%@/campaign", code]
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"campaign"]];
}

+ (LUAPIStub *)stubToGetCampaignWithID:(NSNumber *)campaignID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[@"campaigns/" stringByAppendingString:[campaignID stringValue]]
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:[self responseDataFromFile:@"campaign"]];
}

+ (LUAPIStub *)stubToGetCategories {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"categories"
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:[self responseDataFromFile:@"categories"]];
}

+ (LUAPIStub *)stubToGetCreditAtLocationWithID:(NSNumber *)locationID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[NSString stringWithFormat:@"locations/%@/credit", [locationID stringValue]]
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:[self responseDataFromFile:@"credit"]];
}

+ (LUAPIStub *)stubToGetCreditAndDebitCards {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"credit_cards"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"credit_and_debit"]];
}

+ (LUAPIStub *)stubToGetCreditCardsOneResult {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"credit_cards"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"credit_cards-1"]];
}

+ (LUAPIStub *)stubToGetCreditCardsTwoResults {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"credit_cards"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"credit_cards-2"]];
}

+ (LUAPIStub *)stubToGetCreditCardsThreeResults {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"credit_cards"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"credit_cards-3"]];
}

+ (LUAPIStub *)stubToGetCurrentUser {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:@"users"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"current_user"]];
}

+ (LUAPIStub *)stubToGetCurrentUserDebitOnly {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:@"users"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"current_user_debit_only"]];
}

+ (LUAPIStub *)stubToGetCurrentUserWithoutOptionalInfo {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:@"users"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"current_user_minimal"]];
}

+ (LUAPIStub *)stubToGetCurrentUserWithoutOptionalInfoWithDebitOnly {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:@"users"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"current_user_minimal_debit_only"]];
}

+ (LUAPIStub *)stubToGetDowngradedAccessTokenWithPermissions:(NSArray *)accessTokenPermissions {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion15
                                            path:@"access_tokens/downgrades"
                                      HTTPMethod:@"POST"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"downgraded_token"]];
  stub.requestBodyJSON = @{@"access_token": @{@"permission_keynames": accessTokenPermissions}};
  return stub;
}

+ (LUAPIStub *)stubToGetFeedbackInterstitialForOrderWithUUID:(NSString *)UUID {
  return [LUAPIStubFactory stubToGetInterstitialForOrderWithUUID:UUID fromFile:@"interstitial_feedback"];
}

+ (LUAPIStub *)stubToGetIneligiblePaymentToken {
  LUAPIStub *stub =  [LUAPIStub apiStubForVersion:LUAPIVersion15
                                             path:@"payment_token"
                                       HTTPMethod:@"GET"
                                    authenticated:YES
                                     responseData:[self responseDataFromFile:@"payment_ineligible_error"]];
  stub.responseCode = 404;
  return stub;
}

+ (LUAPIStub *)stubToGetIneligiblePaymentTokenExcessiveChargebacks {
  LUAPIStub *stub =  [LUAPIStub apiStubForVersion:LUAPIVersion15
                                             path:@"payment_token"
                                       HTTPMethod:@"GET"
                                    authenticated:YES
                                     responseData:[self responseDataFromFile:@"payment_ineligible_error_excessive_chargebacks"]];
  stub.responseCode = 404;
  return stub;
}

+ (LUAPIStub *)stubToGetInterstitialForOrderWithUUID:(NSString *)UUID {
  return [LUAPIStubFactory stubToGetInterstitialForOrderWithUUID:UUID fromFile:@"interstitial"];
}

+ (LUAPIStub *)stubToGetInterstitialNotFoundForOrderWithUUID:(NSString *)UUID {
  LUAPIStub *stub = [LUAPIStubFactory stubToGetInterstitialForOrderWithUUID:UUID fromFile:nil];
  stub.responseCode = 404;
  return stub;
}

+ (LUAPIStub *)stubToGetLocationSummariesFirstPage {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:@"locations?first"
                                      HTTPMethod:@"GET"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"location_summaries"]];

  NSString *baseLocationsURLString = [NSString stringWithFormat:@"%@%@/locations", [[LUAPIClient sharedClient].baseURL description], LUAPIVersion14];
  [LUCoreDataStack setMetadataString:[baseLocationsURLString stringByAppendingString:@"?first"] forKey:LUNextPageURLKey];
  stub.responseHeaders = @{@"Link" : [NSString stringWithFormat:@"<%@?last>; rel=\"next\"", baseLocationsURLString]};

  return stub;
}

+ (LUAPIStub *)stubToGetLocationSummariesLastPage {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"locations?last"
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:nil];
}

+ (LUAPIStub *)stubToGetLocationsForAppFirstPageNearLocation:(CLLocation *)location {
  NSString *path = [NSString stringWithFormat:@"apps/%@/locations?lat=%@&lng=%@", [LUAPIClient sharedClient].appID,
                    @(location.coordinate.latitude), @(location.coordinate.longitude)];

  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:path
                                      HTTPMethod:@"GET"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"app_locations"]];

  NSString *baseLocationsURLString = [NSString stringWithFormat:@"%@%@/%@", [[LUAPIClient sharedClient].baseURL description], LUAPIVersion14, path];
  [LUCoreDataStack setMetadataString:[baseLocationsURLString stringByAppendingString:@"&first"] forKey:LUNextPageURLKey];
  stub.responseHeaders = @{@"Link" : [NSString stringWithFormat:@"<%@&last>; rel=\"next\"", baseLocationsURLString]};

  return stub;
}

+ (LUAPIStub *)stubToGetLocationsForAppLastPage {
  NSString *path = [NSString stringWithFormat:@"apps/%@/locations?last", [LUAPIClient sharedClient].appID];

  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:path
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:nil];
}

+ (LUAPIStub *)stubToGetLocationsForMerchantFirstPageNearLocation:(CLLocation *)location forMerchantID:(NSNumber *)merchantID {
  NSString *path = [NSString stringWithFormat:@"merchants/%@/locations?lat=%@&lng=%@", merchantID,
                    @(location.coordinate.latitude), @(location.coordinate.longitude)];

  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion15
                                            path:path
                                      HTTPMethod:@"GET"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"merchant_locations"]];

  NSString *baseLocationsURLString = [NSString stringWithFormat:@"%@%@/%@", [[LUAPIClient sharedClient].baseURL description], LUAPIVersion15, path];
  [LUCoreDataStack setMetadataString:[baseLocationsURLString stringByAppendingString:@"&first"] forKey:LUNextPageURLKey];
  stub.responseHeaders = @{@"Link" : [NSString stringWithFormat:@"<%@&last>; rel=\"next\"", baseLocationsURLString]};

  return stub;
}

+ (LUAPIStub *)stubToGetLocationsForMerchantLastPageForMerchantID:(NSNumber *)merchantID {
  NSString *path = [NSString stringWithFormat:@"merchants/%@/locations?last", merchantID];

  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:path
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:nil];
}

+ (LUAPIStub *)stubToGetLocationWithID:(NSNumber *)locationID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[@"locations/" stringByAppendingString:[locationID stringValue]]
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:[self responseDataFromFile:@"location"]];
}

+ (LUAPIStub *)stubToGetLoyaltyDisabledForMerchantWithID:(NSNumber *)merchantID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[NSString stringWithFormat:@"merchants/%@/loyalty", [merchantID stringValue]]
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"loyalty_disabled"]];
}

+ (LUAPIStub *)stubToGetLoyaltyForMerchantWithID:(NSNumber *)merchantID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:[NSString stringWithFormat:@"merchants/%@/loyalty", [merchantID stringValue]]
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"loyalty"]];
}

+ (LUAPIStub *)stubToGetLoyaltyNoCreditForMerchantWithID:(NSNumber *)merchantID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:[NSString stringWithFormat:@"merchants/%@/loyalty", [merchantID stringValue]]
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"loyalty_no_credit"]];
}

+ (LUAPIStub *)stubToGetMerchantIDs:(NSArray *)merchantIDs forCampaignWithID:(NSNumber *)campaignID {
  NSString *path = [NSString stringWithFormat:@"campaigns/%@/merchants", [campaignID stringValue]];

  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:path
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:[self responseDataFromJSON:merchantIDs]];
}

+ (LUAPIStub *)stubToGetNewUser {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:@"users"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"new_user"]];
}

+ (LUAPIStub *)stubToGetOrderWithUUID:(NSString *)UUID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:[@"orders/" stringByAppendingString:UUID]
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"order"]];
}

+ (LUAPIStub *)stubToGetOrdersEmpty {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:@"apps/orders"
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:nil];
}

+ (LUAPIStub *)stubToGetOrdersFirstPage {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion15
                                            path:@"apps/orders"
                                      HTTPMethod:@"GET"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"orders_page-1"]];

  NSString *nextPageURLString = [NSString stringWithFormat:@"%@?page=2", [stub.URL absoluteString]];
  stub.responseHeaders = @{@"Link" : [NSString stringWithFormat:@"<%@>; rel=\"next\"", nextPageURLString]};

  return stub;
}

+ (LUAPIStub *)stubToGetOrdersLastPage {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:@"apps/orders?last"
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:nil];
}

+ (LUAPIStub *)stubToGetOrdersSecondPage {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion15
                                            path:@"apps/orders?page=2"
                                      HTTPMethod:@"GET"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"orders_page-2"]];

  NSString *nextPageURLString = [[stub.URL absoluteString] stringByReplacingOccurrencesOfString:@"page=2" withString:@"last"];
  stub.responseHeaders = @{@"Link" : [NSString stringWithFormat:@"<%@>; rel=\"next\"", nextPageURLString]};

  return stub;
}

+ (LUAPIStub *)stubToGetPassWithMerchantID:(NSNumber *)merchantID {
  NSString *path = @"pass";
  if (merchantID) {
    path = [path stringByAppendingFormat:@"?merchant_id=%@", merchantID];
  }

  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:path
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"pass"]];
}

+ (LUAPIStub *)stubToGetPaymentToken {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:@"payment_token"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"payment_token"]];
}

+ (LUAPIStub *)stubToGetPendingPassWithMerchantID:(NSNumber *)merchantID {
  LUAPIStub *stub = [self stubToGetPassWithMerchantID:merchantID];
  stub.responseCode = 202;
  stub.responseData = nil;
  return stub;
}

+ (LUAPIStub *)stubToGetURL:(NSString *)url withBody:(NSString *)body {
  return [LUAPIStub stubForWebURL:[NSURL URLWithString:url]
                         withBody:body];
}

+ (LUAPIStub *)stubToGetWebLinksAtLocationWithID:(NSNumber *)locationID {
  NSString *path = [NSString stringWithFormat:@"locations/%@/web_links", [locationID stringValue]];

  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                            path:path
                                      HTTPMethod:@"GET"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"web_links"]];

}

+ (LUAPIStub *)stubToLogIn {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"access_tokens"
                           HTTPMethod:@"POST"
                        authenticated:NO
                         responseData:[self responseDataFromFile:@"oauth_access_token"]];
}

+ (LUAPIStub *)stubToLogInWithEmail:(NSString *)email password:(NSString *)password {
  LUAPIStub *stub = [self stubToLogIn];

  stub.requestBodyJSON = @{
    @"access_token" : @{
      @"api_key" : [LUAPIClient sharedClient].apiKey,
      @"device_identifier" : [LUDeviceIdentifier deviceIdentifier],
      @"password" : password,
      @"username" : email
    }
  };

  return stub;
}

+ (LUAPIStub *)stubToPromoteCreditCardWithID:(NSNumber *)creditCardID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[@"credit_cards/" stringByAppendingString:[creditCardID stringValue]]
                           HTTPMethod:@"PUT"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"credit_card"]];
}

+ (LUAPIStub *)stubToResetPasswordRequest {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"passwords"
                           HTTPMethod:@"POST"
                        authenticated:NO
                         responseData:nil];
}

+ (LUAPIStub *)stubToSubmitFeedbackForOrderWithUUID:(NSString *)UUID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:[NSString stringWithFormat:@"orders/%@/feedback", UUID]
                           HTTPMethod:@"POST"
                        authenticated:NO
                         responseData:nil];
}

+ (LUAPIStub *)stubToUpdateUser {
  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:@"users"
                           HTTPMethod:@"PUT"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"current_user"]];
}

+ (LUAPIStub *)stubToUpdateUser:(LUUser *)user {
  LUAPIStub *stub = [self stubToUpdateUser];

  NSDictionary *userJSON = @{@"user" : [LUUserParameterBuilder parametersForUser:user] };
  stub.responseData = [self responseDataFromJSON:userJSON];
  stub.requestBodyJSON = userJSON;

  return stub;
}

#pragma mark - Private Methods

+ (NSDictionary *)requestBodyJSONForUser:(LUUser *)user {
  NSDictionary *userJSON = [LUUserParameterBuilder parametersForUser:user];
  return @{ @"api_key" : [LUAPIClient sharedClient].apiKey, @"user" : userJSON };
}

+ (NSData *)responseDataFromFile:(NSString *)file {
  NSString *responseFile = [[NSBundle bundleForClass:[self class]] pathForResource:file ofType:@"json"];
  return [NSData dataWithContentsOfFile:responseFile];
}

+ (NSData *)responseDataFromJSON:(id)JSON {
  if (!JSON) return nil;

  return [NSJSONSerialization dataWithJSONObject:JSON options:0 error:nil];
}

+ (NSDictionary *)responseJSONForUser:(LUUser *)user {
  NSMutableDictionary *responseUserJSON = [[LUUserParameterBuilder parametersForUser:user] mutableCopy];
  if (user.termsAccepted) {
    responseUserJSON[@"terms_accepted_at"] = [[NSDate date] lu_iso8601DateTimeString];
  }

  return @{ @"user" : responseUserJSON };
}

+ (LUAPIStub *)stubToCreatePaymentCardWithNumber:(NSString *)number
                                             cvv:(NSString *)cvv
                                 expirationMonth:(NSNumber *)expirationMonth
                                  expirationYear:(NSNumber *)expirationYear
                                      postalCode:(NSString *)postalCode
                            responseDataFileName:(NSString *)responseDataFileName {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion15
                                            path:@"credit_cards"
                                      HTTPMethod:@"POST"
                                   authenticated:YES
                                    responseData:[self responseDataFromFile:responseDataFileName]];
  stub.requestBodyJSON = @{
    @"credit_card" : @{
      @"encrypted_cvv" : cvv,
      @"encrypted_expiration_month" : [expirationMonth stringValue],
      @"encrypted_expiration_year" : [expirationYear stringValue],
      @"encrypted_number" : number,
      @"postal_code" : postalCode
    }
  };
  return stub;
}

+ (LUAPIStub *)stubToGetInterstitialForOrderWithUUID:(NSString *)UUID fromFile:(NSString *)file {
  NSString *path = [NSString stringWithFormat:@"orders/%@/interstitial", UUID];

  return [LUAPIStub apiStubForVersion:LUAPIVersion15
                                 path:path
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:file]];
}

@end
