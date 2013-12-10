// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAPIStub.h"
#import "LUAPIStubFactory.h"
#import "LUCoreDataStack.h"
#import "LUKeychainAccess.h"
#import "LULocationCacheUpdater.h"
#import "LUUser.h"
#import "LUUserParameterBuilder.h"
#import "NSDate+StringFormats.h"

NSString * const LUDeviceIdentifier = @"abcdefg";

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

  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[NSString stringWithFormat:@"codes/%@/claims", code]
                           HTTPMethod:@"POST"
                        authenticated:YES
                         responseData:[self responseDataFromJSON:responseJSON]];
}

+ (LUAPIStub *)stubToClaimLegacyLoyaltyWithID:(NSString *)loyaltyID campaignID:(NSNumber *)campaignID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
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
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:@"credit_cards"
                                      HTTPMethod:@"POST"
                                   authenticated:YES
                                    responseData:[self responseDataFromFile:@"credit_card"]];
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

  [self setDeviceIdentifier];

  NSDictionary *userJSON = [LUUserParameterBuilder parametersForUser:user];
  stub.requestBodyJSON = @{ @"client_id" : [LUAPIClient sharedClient].apiKey, @"user" : userJSON };

  NSMutableDictionary *responseUserJSON = [userJSON mutableCopy];
  if (user.termsAccepted) {
    responseUserJSON[@"terms_accepted_at"] = [[NSDate date] lu_iso8601DateTimeString];
  }
  NSDictionary *responseJSON = @{ @"user" : responseUserJSON };

  stub.responseData = [self responseDataFromJSON:responseJSON];

  return stub;
}

+ (LUAPIStub *)stubToCreateUserWithFacebookAccessToken:(NSString *)facebookAccessToken {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:@"users"
                                      HTTPMethod:@"POST"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"new_user"]];

  [self setDeviceIdentifier];

  stub.requestBodyJSON = @{
    @"client_id" : [LUAPIClient sharedClient].apiKey,
    @"user" : @{
      @"device_identifier" : LUDeviceIdentifier,
      @"facebook_access_token" : facebookAccessToken
    }
  };

  return stub;
}

+ (LUAPIStub *)stubToDeleteCreditCardWithID:(NSNumber *)creditCardID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[@"credit_cards/" stringByAppendingString:[creditCardID stringValue]]
                           HTTPMethod:@"DELETE"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"credit_card"]];
}

+ (LUAPIStub *)stubToFacebookConnectWithFacebookAccessToken:(NSString *)facebookAccessToken {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:@"facebook_connection"
                                      HTTPMethod:@"POST"
                                   authenticated:YES
                                    responseData:nil];
  stub.requestBodyJSON = @{@"user" : @{@"facebook_access_token" : facebookAccessToken} };
  return stub;
}

+ (LUAPIStub *)stubToFacebookDisconnect {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"facebook_connection"
                           HTTPMethod:@"DELETE"
                        authenticated:YES
                         responseData:nil];
}

+ (LUAPIStub *)stubToFailToClaimCampaignWithCode:(NSString *)code {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:[NSString stringWithFormat:@"codes/%@/claims", code]
                                      HTTPMethod:@"POST"
                                   authenticated:YES
                                    responseData:[self responseDataFromFile:@"failed_claim"]];
  stub.responseCode = 404;
  return stub;
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

+ (LUAPIStub *)stubToGetCurrentFacebookConnectedUser {
  LUAPIStub *stub = [self stubToGetCurrentUser];
  stub.responseData = [self responseDataFromFile:@"facebook_connected_user"];
  return stub;
}

+ (LUAPIStub *)stubToGetCurrentUser {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"users/1"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"current_user"]];
}

+ (LUAPIStub *)stubToGetCurrentUserWithoutOptionalInfo {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"users/1"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"current_user_minimal"]];
}

+ (LUAPIStub *)stubToGetIneligiblePaymentToken {
  LUAPIStub *stub =  [LUAPIStub apiStubForVersion:LUAPIVersion14
                                             path:@"payment_token"
                                       HTTPMethod:@"GET"
                                    authenticated:YES
                                     responseData:nil];
  stub.responseCode = 404;
  return stub;
}

+ (LUAPIStub *)stubToGetInterstitialNotFoundForOrderWithUUID:(NSString *)UUID {
  NSString *path = [NSString stringWithFormat:@"orders/%@/interstitial", UUID];

  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:path
                                      HTTPMethod:@"GET"
                                   authenticated:YES
                                    responseData:nil];
  stub.responseCode = 404;
  return stub;
}

+ (LUAPIStub *)stubToGetInterstitialForOrderWithUUID:(NSString *)UUID {
  NSString *path = [NSString stringWithFormat:@"orders/%@/interstitial", UUID];

  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:path
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"interstitial"]];
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
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[NSString stringWithFormat:@"merchants/%@/loyalty", [merchantID stringValue]]
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"loyalty"]];
}

+ (LUAPIStub *)stubToGetLoyaltyNoCreditForMerchantWithID:(NSNumber *)merchantID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
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

+ (LUAPIStub *)stubToGetMerchantWithID:(NSNumber *)merchantID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion13
                                 path:[@"merchants/" stringByAppendingString:[merchantID stringValue]]
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:[self responseDataFromFile:@"merchant"]];
}

+ (LUAPIStub *)stubToGetNewUser {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"users/1"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"new_user"]];
}

+ (LUAPIStub *)stubToGetOrderWithUUID:(NSString *)UUID {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:[@"orders/" stringByAppendingString:UUID]
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"order"]];
}

+ (LUAPIStub *)stubToGetOrdersFirstPage {
  NSString *path = [NSString stringWithFormat:@"apps/%@/orders", [LUAPIClient sharedClient].appID];

  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:path
                                      HTTPMethod:@"GET"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"orders_page-1"]];

  NSString *nextPageURLString = [NSString stringWithFormat:@"%@?page=2", [stub.URL absoluteString]];
  stub.responseHeaders = @{@"Link" : [NSString stringWithFormat:@"<%@>; rel=\"next\"", nextPageURLString]};

  return stub;
}

+ (LUAPIStub *)stubToGetOrdersLastPage {
  NSString *path = [NSString stringWithFormat:@"apps/%@/orders?last", [LUAPIClient sharedClient].appID];

  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:path
                           HTTPMethod:@"GET"
                        authenticated:NO
                         responseData:nil];
}

+ (LUAPIStub *)stubToGetOrdersSecondPage {
  NSString *path = [NSString stringWithFormat:@"apps/%@/orders?page=2", [LUAPIClient sharedClient].appID];

  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:path
                                      HTTPMethod:@"GET"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"orders_page-2"]];

  NSString *nextPageURLString = [[stub.URL absoluteString] stringByReplacingOccurrencesOfString:@"page=2" withString:@"last"];
  stub.responseHeaders = @{@"Link" : [NSString stringWithFormat:@"<%@>; rel=\"next\"", nextPageURLString]};

  return stub;
}

+ (LUAPIStub *)stubToGetPaymentToken {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"payment_token"
                           HTTPMethod:@"GET"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"payment_token"]];
}

+ (LUAPIStub *)stubToGetURL:(NSString *)url withBody:(NSString *)body {
  return [LUAPIStub stubForWebURL:[NSURL URLWithString:url]
                         withBody:body];
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

  [self setDeviceIdentifier];
  stub.requestBodyJSON = @{
    @"access_token" : @{
      @"client_id" : [LUAPIClient sharedClient].apiKey,
      @"device_identifier" : LUDeviceIdentifier,
      @"password" : password,
      @"username" : email
    }
  };

  return stub;
}

+ (LUAPIStub *)stubToLogInWithFacebookAccessToken:(NSString *)facebookAccessToken {
  LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                            path:@"access_tokens"
                                      HTTPMethod:@"POST"
                                   authenticated:NO
                                    responseData:[self responseDataFromFile:@"oauth_access_token"]];

  [self setDeviceIdentifier];
  stub.requestBodyJSON = @{
    @"access_token" : @{
      @"client_id" : [LUAPIClient sharedClient].apiKey,
      @"device_identifier" : LUDeviceIdentifier,
      @"facebook_access_token" : facebookAccessToken
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

+ (LUAPIStub *)stubToUpdateUser {
  return [LUAPIStub apiStubForVersion:LUAPIVersion14
                                 path:@"users/1"
                           HTTPMethod:@"PUT"
                        authenticated:YES
                         responseData:[self responseDataFromFile:@"current_user"]];
}

+ (LUAPIStub *)stubToUpdateUser:(LUUser *)user {
  LUAPIStub *stub = [self stubToUpdateUser];
  [self setDeviceIdentifier];

  NSDictionary *userJSON = @{@"user" : [LUUserParameterBuilder parametersForUser:user] };
  stub.responseData = [self responseDataFromJSON:userJSON];
  stub.requestBodyJSON = userJSON;

  return stub;
}

#pragma mark - Private Methods

+ (NSData *)responseDataFromFile:(NSString *)file {
  NSString *responseFile = [[NSBundle bundleForClass:[self class]] pathForResource:file ofType:@"json"];
  return [NSData dataWithContentsOfFile:responseFile];
}

+ (NSData *)responseDataFromJSON:(id)JSON {
  if (!JSON) return nil;

  return [NSJSONSerialization dataWithJSONObject:JSON options:0 error:nil];
}

+ (void)setDeviceIdentifier {
  [[LUKeychainAccess standardKeychainAccess] setString:LUDeviceIdentifier forKey:@"LUDeviceIdentifier"];
}

@end
