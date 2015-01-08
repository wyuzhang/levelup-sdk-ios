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

#import <PassKit/PassKit.h>
#import "LUAPIClient.h"
#import "LUAPIResponse.h"
#import "LUPassRequestFactory.h"
#import "LUPassRetriever.h"

@interface LUPassRetriever ()

@property (nonatomic, copy, readonly) LUPassRetrieverCompletionHandlerBlock completionHandler;
@property (nonatomic, copy, readonly) NSNumber *merchantID;

@end

@implementation LUPassRetriever

#pragma mark - Object Lifecycle Methods

+ (void)retrieveAppPassWithCompletionHandler:(LUPassRetrieverCompletionHandlerBlock)block {
  [[[self alloc] initWithCompletionHandler:block merchantID:nil] retrievePass];
}

+ (void)retrievePassForMerchantWithID:(NSNumber *)merchantID withCompletionHandler:(LUPassRetrieverCompletionHandlerBlock)block {
  [[[self alloc] initWithCompletionHandler:block merchantID:merchantID] retrievePass];
}

- (instancetype)initWithCompletionHandler:(LUPassRetrieverCompletionHandlerBlock)completionHandler merchantID:(NSNumber *)merchantID {
  self = [super init];
  if (!self) return nil;

  _completionHandler = completionHandler;
  _merchantID = merchantID;

  return self;
}

#pragma mark - Public Methods

- (void)retrievePass {
  LUAPIRequest *request;
  if (self.merchantID) {
    request = [LUPassRequestFactory requestForPassWithMerchantID:self.merchantID];
  } else {
    request = [LUPassRequestFactory requestForAppPass];
  }

  [[LUAPIClient sharedClient] performRequest:request
                                     success:^(NSDictionary *result, LUAPIResponse *response) {
                                       [self downloadPassWithURL:[NSURL URLWithString:result[@"url"]]
                                             authenticationToken:result[@"authentication_token"]];
                                     }
                                     failure:^(NSError *error) {
                                       self.completionHandler(nil, error);
                                     }];
}

#pragma mark - Private Methods

- (void)downloadPassWithURL:(NSURL *)URL authenticationToken:(NSString *)authenticationToken {
  NSMutableURLRequest *passRequest = [NSMutableURLRequest requestWithURL:URL];
  [passRequest addValue:[@"ApplePass " stringByAppendingString:authenticationToken]
     forHTTPHeaderField:@"Authorization"];

  [NSURLConnection sendAsynchronousRequest:passRequest
                                     queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                           if (connectionError) {
                             self.completionHandler(nil, connectionError);
                             return;
                           }

                           NSError *passError;
                           PKPass *pass = [[PKPass alloc] initWithData:data error:&passError];

                           self.completionHandler(pass, passError);
                         }];
}

@end
