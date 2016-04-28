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

#import "LUConstants.h"

NSString * const LevelUpSDKVersion = @"1.9.3";

NSString * const BraintreePublicKeyDevelopment = @"MIIBCgKCAQEAxNUyPf89izTCl00dz+hRu6pbNsyI3aoEH/vUnloIG7FFgXIfzDGIQPHOPEqwaZjG6BaE1MPSVMIGKpQ5slYCvJlYByyBi/Ymhh4FYq/SRxZRhBa81waKEE4br7y7DQQnfb7EaFrvUQVpxP5e7vo5LNNCCLr+Ax/3MEVC1sm0SsPOgjt6c0/UcrfD8dW+qSEkE1slab1nY3kSdCyEKaMZvZEYE/hyEIP3+i9vnlXZ+ysDUpU5KqwRz20P59owCwCJB8pdok6uaHbFjsCweF5BhMl2YI9pBktzUd2EFO0eXmw9ZnVYgthpqV45/fABoBv7Lf3IUHd8nme3ACJ75aMTzwIDAQAB";
NSString * const BraintreePublicKeyProduction = @"MIIBCgKCAQEAsWqrT3RkCyH6yF7ir/lphFcc/lKk792OG5sCGW2dZW3A0NDVoNOpoP0Qj6S0uqgT5higISchdJKSaqurE0fBzqpys0n+o3jTShOxsAS+k1urH7kPtW3DSw9HPVZuKkY+C8a3JcfkFb7OLQsolDGmJdI7BLlt/KB52Z7rP2EqsjqrI+HMLgjN8zWnAl6RbAFNyAsHniww8z/z1BcXhen9UTr9LXcbhZjVjsOrGNR7Ylc2uaLbg/NRuEImXhGc53Dd0DSeKocEG4jdrwZSQFVZjf2D+Hoj11bivkhrd1dwa43rik4cr4qEOlRIdq/DbIroq2tTn46nwOmPd8cFSbu81wIDAQAB";

NSString * const LevelUpAPIBaseURLDevelopment = @"https://sandbox.thelevelup.com/";
NSString * const LevelUpAPIBaseURLProduction = @"https://api.thelevelup.com/";
NSString * const LevelUpOAuth2BaseURLDevelopment = @"https://sandbox.thelevelup.com/";
NSString * const LevelUpOAuth2BaseURLProduction = @"https://www.thelevelup.com/";

#pragma mark - Deep Link Auth URL Host & Params

NSString * const LUDeepLinkAuthRequestHost = @"authorization";
NSString * const LUDeepLinkAuthResponseHost = @"authorization_response";

#pragma mark - Deep Link Auth Notifications

NSString * const LUDeepLinkAuthErrorNotification = @"LUDeepLinkAuthErrorNotification";
NSString * const LUDeepLinkAuthSuccessNotification = @"LUDeepLinkAuthSuccessNotification";

NSString * const LUDeepLinkAuthNotificationAccessTokenKey = @"LUDeepLinkAuthNotificationAccessTokenKey";
NSString * const LUDeepLinkAuthNotificationErrorKey = @"LUDeepLinkAuthNotificationErrorKey";

#pragma mark - Payment Token Actions

NSString * const LUPaymentTokenActionAddPaymentMethod = @"add_payment_method";

#pragma mark - Permissions

NSString * const LUPermissionBeaconCheckins = @"beacon_checkins";
NSString * const LUPermissionCreateOrders = @"create_orders";
NSString * const LUPermissionManageUserAddresses = @"manage_user_addresses";
NSString * const LUPermissionManageUserCampaigns = @"manage_user_campaigns";
NSString * const LUPermissionManageUserPaymentMethods = @"manage_user_payment_methods";
NSString * const LUPermissionReadQRCode = @"read_qr_code";
NSString * const LUPermissionReadUserBasicInfo = @"read_user_basic_info";
NSString * const LUPermissionReadUserOrders = @"read_user_orders";

#pragma mark - API Errors

NSString * const LUAPIErrorDomain = @"LUAPIErrorDomain";
NSString * const LUAPIErrorKeyAPIErrors = @"LUAPIErrorKeyAPIErrors";
NSString * const LUAPIErrorKeyErrorMessage = @"LUAPIErrorKeyErrorMessage";
NSString * const LUAPIErrorKeyJSONResponse = @"LUAPIErrorKeyJSONResponse";
NSString * const LUAPIErrorKeyOriginalError = @"LUAPIErrorKeyOriginalError";
NSString * const LUAPIErrorKeyURLResponse = @"LUAPIErrorKeyURLResponse";

#pragma mark - Carrier Account Errors

NSString * const LUCarrierAccountErrorDomain = @"LUCarrierAccountErrorDomain";

#pragma mark - Deep Link Auth Errors

NSString * const LUDeepLinkAuthErrorDomain = @"LUDeepLinkAuthErrorDomain";
