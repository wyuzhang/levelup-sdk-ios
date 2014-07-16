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

#import "AFHTTPRequestOperation.h"
#import "LUAPIConnection.h"

SPEC_BEGIN(LUAPIConnectionSpec)

describe(@"LUAPIConnection", ^{
  AFHTTPRequestOperation *httpRequestOperation = [[AFHTTPRequestOperation alloc] init];
  LUAPIConnection *apiConnection = [[LUAPIConnection alloc] initWithAFHTTPRequestOperation:httpRequestOperation];

  describe(@"operation", ^{
    it(@"returns the AFHTTPRequestOperation", ^{
      [[apiConnection.operation should] equal:httpRequestOperation];
    });
  });

  describe(@"failureCallbackQueue property", ^{
    it(@"delegates to the AFHTTPRequestOperation", ^{
      dispatch_queue_t queue = dispatch_get_main_queue();

      apiConnection.failureCallbackQueue = queue;

      [[theValue(httpRequestOperation.completionQueue) should] equal:theValue(apiConnection.failureCallbackQueue)];
    });
  });

  describe(@"successCallbackQueue property", ^{
    it(@"delegates to the AFHTTPRequestOperation", ^{
      dispatch_queue_t queue = dispatch_get_main_queue();

      apiConnection.successCallbackQueue = queue;

      [[theValue(httpRequestOperation.completionQueue) should] equal:theValue(apiConnection.successCallbackQueue)];
    });
  });
});

SPEC_END
