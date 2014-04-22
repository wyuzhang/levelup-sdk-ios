// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUConstants.h"

NSString * const LevelUpSDKVersion = @"1.3.0";

NSString * const BraintreePublicKeyDevelopment = @"MIIBCgKCAQEAp49Q/fDFmke3AcTyzFcd82aO6sTubTzAzX+bLUt8Jf0qqkj2ktoSsBtJfHHQ6c26+9pYNPSd9gviPoqitKmnfu1ZJiuxTkjG/tIxbtblhU4v6gAEbynj0GI58rrURJwtCwHKzrYXMx64BDV2xajfqbuqrHu7wYEjBFv2WZ0ugAv6gf7WcK/YKfN5LgHoNc5toEoqTT0tOAeYF9eNH92H4rGFIl8wpuYSL8WqmLKmhJIxC6I9sO/ZJQX+uMOqohZeJdRDDrKGvwzsEgR9x3qCgexdb8iwlpDWd6AYog5BRNUu7qI9hdvODhBklcyccMZdfnZnzmtfRqXV6XOsHA5CWQIDAQAB";
NSString * const BraintreePublicKeyProduction = @"MIIBCgKCAQEAsWqrT3RkCyH6yF7ir/lphFcc/lKk792OG5sCGW2dZW3A0NDVoNOpoP0Qj6S0uqgT5higISchdJKSaqurE0fBzqpys0n+o3jTShOxsAS+k1urH7kPtW3DSw9HPVZuKkY+C8a3JcfkFb7OLQsolDGmJdI7BLlt/KB52Z7rP2EqsjqrI+HMLgjN8zWnAl6RbAFNyAsHniww8z/z1BcXhen9UTr9LXcbhZjVjsOrGNR7Ylc2uaLbg/NRuEImXhGc53Dd0DSeKocEG4jdrwZSQFVZjf2D+Hoj11bivkhrd1dwa43rik4cr4qEOlRIdq/DbIroq2tTn46nwOmPd8cFSbu81wIDAQAB";

NSString * const LevelUpAPIBaseURLDevelopment = @"https://api.staging-levelup.com/";
NSString * const LevelUpAPIBaseURLProduction = @"https://api.thelevelup.com/";

#pragma mark - Deep Link Auth URL Host & Params

NSString * const LUDeepLinkAuthRequestHost = @"authorization";
NSString * const LUDeepLinkAuthResponseHost = @"authorization_response";

#pragma mark - Deep Link Auth Notifications

NSString * const LUDeepLinkAuthErrorNotification = @"LUDeepLinkAuthErrorNotification";
NSString * const LUDeepLinkAuthSuccessNotification = @"LUDeepLinkAuthSuccessNotification";

NSString * const LUDeepLinkAuthNotificationAccessTokenKey = @"LUDeepLinkAuthNotificationAccessTokenKey";
NSString * const LUDeepLinkAuthNotificationErrorKey = @"LUDeepLinkAuthNotificationErrorKey";

#pragma mark - API Errors

NSString * const LUAPIErrorDomain = @"LUAPIErrorDomain";
NSString * const LUAPIErrorKeyAPIErrors = @"LUAPIErrorKeyAPIErrors";
NSString * const LUAPIErrorKeyErrorMessage = @"LUAPIErrorKeyErrorMessage";
NSString * const LUAPIErrorKeyJSONResponse = @"LUAPIErrorKeyJSONResponse";
NSString * const LUAPIErrorKeyOriginalError = @"LUAPIErrorKeyOriginalError";
NSString * const LUAPIErrorKeyURLResponse = @"LUAPIErrorKeyURLResponse";

#pragma mark - Deep Link Auth Errors

NSString * const LUDeepLinkAuthErrorDomain = @"LUDeepLinkAuthErrorDomain";
