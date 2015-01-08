/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

#import "AFHTTPRequestOperationManager.h"
#import "LUAPIClient.h"
#import "LUAPIResponse.h"
#import "LUCarrierAccount.h"
#import "LUCarrierAccountRequestFactory.h"
#import "LUCarrierAccountRetriever.h"
#import "LUCarrierNetworkDetector.h"
#import "NSError+LUAdditions.h"

NSString *const LUCarrierAccountDataConnectionErrorDescription = @"Carrier billing sign up requires that you are connected to your cellular data network and not on WiFi. You can re-enable WiFi after the sign up process is completed.";
NSString *const LUCarrierAccountIdentificationErrorDescription = @"We encountered a problem identifying your carrier network. Please try again shortly.";

@implementation LUCarrierAccountRetriever

+ (void)retrieveMDNSuppliedCarrierAccountWithCompletionHandler:(LUCarrierAccountRetrieverCompletionHandlerBlock)completionHandler {
  if ([LUCarrierNetworkDetector deviceIsConnectedToCarrierCellularData]) {
    [[LUAPIClient sharedClient] performRequest:[LUCarrierAccountRequestFactory requestForCarrierAccountIdentification]
                                       success:^(LUCarrierAccount *carrierAccount, LUAPIResponse *response) {
                                         [self retrieveEVURLSuppliedCarrierAccountWithID:carrierAccount.carrierAccountID
                                                                   withCompletionHandler:completionHandler];
                                       }
                                       failure:^(NSError *error) {
                                         return completionHandler(nil, error);
                                       }];
  } else {
    return completionHandler(nil, [NSError lu_carrierAccountErrorWithCode:LUCarrierAccountErrorDataConnectionRequired
                                                              description:LUCarrierAccountDataConnectionErrorDescription]);
  }
}

+ (void)updateCarrierAccount:(LUCarrierAccount *)carrierAccount
       withCompletionHandler:(LUCarrierAccountRetrieverCompletionHandlerBlock)completionHandler {
  [[LUAPIClient sharedClient]
   performRequest:[LUCarrierAccountRequestFactory requestToUpdateCarrierAccountWithID:carrierAccount.carrierAccountID
                                                                   mobileDeviceNumber:carrierAccount.mobileDeviceNumber
                                                                          carrierName:carrierAccount.carrierName]
   success:^(LUCarrierAccount *carrierAccount, LUAPIResponse *response) {
     [self retrieveEligibilityUpdatedCarrierAccountWithID:carrierAccount.carrierAccountID
                                    withCompletionHandler:completionHandler];
   } failure:^(NSError *error) {
     return completionHandler(nil, error);
   }];
}

#pragma mark - Private Methods

+ (void)retrieveEligibilityUpdatedCarrierAccountWithID:(NSNumber *)carrierAccountID
                                 withCompletionHandler:(LUCarrierAccountRetrieverCompletionHandlerBlock)completionHandler {
  [[LUAPIClient sharedClient] performRequest:[LUCarrierAccountRequestFactory requestForUpdatedCarrierAccountWithID:carrierAccountID]
                                     success:^(LUCarrierAccount *carrierAccount, LUAPIResponse *response) {
                                       return completionHandler(carrierAccount, nil);
                                     }
                                     failure:^(NSError *error) {
                                       return completionHandler(nil, error);
                                     }];
}

+ (void)retrieveEVURLSuppliedCarrierAccountWithID:(NSNumber *)carrierAccountID
                            withCompletionHandler:(LUCarrierAccountRetrieverCompletionHandlerBlock)completionHandler {
  [[LUAPIClient sharedClient] performRequest:[LUCarrierAccountRequestFactory requestForUpdatedCarrierAccountWithID:carrierAccountID]
                                     success:^(LUCarrierAccount *carrierAccount, LUAPIResponse *response) {
                                       [self retrieveMDNSuppliedCarrierAccountWithID:carrierAccountID
                                                                               EVURL:carrierAccount.EVURL
                                                                   completionHandler:completionHandler];
                                     }
                                     failure:^(NSError *error) {
                                       return completionHandler(nil, error);
                                     }];
}

+ (void)retrieveMDNSuppliedCarrierAccountWithID:(NSNumber *)carrierAccountID EVURL:(NSURL *)EVURL
                              completionHandler:(LUCarrierAccountRetrieverCompletionHandlerBlock)completionHandler {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];

  [manager GET:[EVURL absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSDictionary *responseKeyValuePairs = [self parsedKeyValuePairsFromResponseObject:responseObject];

    NSString *statusString = [responseKeyValuePairs valueForKey:@"Status"];
    NSString *MDN = [responseKeyValuePairs valueForKey:@"MDN"];
    NSString *carrierName = [responseKeyValuePairs valueForKey:@"Carrier"];

    if ([statusString isEqualToString:@"Success"]) {
      LUCarrierAccount *identifiedCarrierAccount =
      [[LUCarrierAccount alloc] initWithCarrierAccountID:carrierAccountID
                                             carrierName:carrierName
                                            creditCardID:nil
                                                   EVURL:EVURL
                                      mobileDeviceNumber:MDN
                                                   state:LUCarrierAccountStateIdentified];
      return completionHandler(identifiedCarrierAccount, nil);
    } else {
      return completionHandler(nil, [NSError lu_carrierAccountErrorWithCode:LUCarrierAccountErrorProblemIdentifyingNetwork
                                                                description:LUCarrierAccountIdentificationErrorDescription]);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    return completionHandler(nil, error);
  }];
}

+ (NSDictionary *)parsedKeyValuePairsFromResponseObject:(id)responseObject {
  NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
  NSMutableDictionary *responseDict = [NSMutableDictionary dictionary];
  NSArray *keyValuePairs = [responseString componentsSeparatedByString:@"&"];

  for (NSString *keyValuePair in keyValuePairs) {
    NSArray *keyValueArray = [keyValuePair componentsSeparatedByString:@"="];
    NSString *key = [keyValueArray objectAtIndex:0];
    NSString *value = [keyValueArray objectAtIndex:1];
    [responseDict setObject:value forKey:key];
  }

  return responseDict;
}

@end
