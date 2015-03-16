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

#import "LUAPIStub.h"
#import "LUAPIStubbing.h"
#import "LUConstants.h"
#import <OHHTTPStubs/OHHTTPStubs.h>

@interface LUAPIStubbing ()

@property (nonatomic, strong) NSMutableArray *mutableStubs;
@property (nonatomic, assign) BOOL raiseOnUnexpectedRequest;

@end

@implementation LUAPIStubbing

#pragma mark - Public Methods

+ (instancetype)sharedInstance {
  static LUAPIStubbing *sharedInstance = nil;

  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    sharedInstance = [[self alloc] init];
  });

  return sharedInstance;
}

- (id)init {
  self = [super init];
  if (!self) return nil;

  _mutableStubs = [NSMutableArray array];

  return self;
}

- (void)clearStubs {
  [self.mutableStubs removeAllObjects];

  [OHHTTPStubs removeAllRequestHandlers];
  [OHHTTPStubs setEnabled:NO];
}

- (void)addStub:(LUAPIStub *)stub {
  [self addOrReplaceStub:stub];

  [OHHTTPStubs setEnabled:YES];
  [OHHTTPStubs removeAllRequestHandlers];

  [OHHTTPStubs addRequestHandler:^OHHTTPStubsResponse *(NSURLRequest *request, BOOL onlyCheck) {
    for (LUAPIStub *stub in [self.mutableStubs reverseObjectEnumerator]) {
      if ([stub matchesRequest:request]) {
        if (onlyCheck) {
          return OHHTTPStubsResponseUseStub;
        } else {
          return [stub response];
        }
      }
    }

    if (self.raiseOnUnexpectedRequest) {
      [NSException raise:@"LUAPIStubbing Exception" format:@"LUAPIStubbing received unexpected request: %@", request];
    }
    return [[OHHTTPStubsResponse alloc] initWithError:[NSError errorWithDomain:LUAPIErrorDomain code:LUAPIErrorNetwork userInfo:nil]];
  }];
}

- (void)disableNetConnect {
  [OHHTTPStubs setEnabled:YES];
  [OHHTTPStubs removeAllRequestHandlers];

  [OHHTTPStubs addRequestHandler:^OHHTTPStubsResponse *(NSURLRequest *request, BOOL onlyCheck) {
    if (self.raiseOnUnexpectedRequest) {
      [NSException raise:@"LUAPIStubbing Exception" format:@"LUAPIStubbing received unexpected request: %@", request];
    }
    return [[OHHTTPStubsResponse alloc] initWithError:[NSError errorWithDomain:LUAPIErrorDomain code:LUAPIErrorNetwork userInfo:nil]];
  }];
}

- (void)raiseOnUnexpectedRequest:(BOOL)raiseOnUnexpectedRequest {
  self.raiseOnUnexpectedRequest = raiseOnUnexpectedRequest;
}

- (NSArray *)stubs {
  return [[NSArray alloc] initWithArray:self.mutableStubs copyItems:YES];
}

#pragma mark - Private Methods

- (void)addOrReplaceStub:(LUAPIStub *)stub {
  for (int i = 0; i < self.mutableStubs.count; i++) {
    if ([self.mutableStubs[i] isEqual:stub]) {
      self.mutableStubs[i] = stub;
      return;
    }
  }
  [self.mutableStubs addObject:stub];
}

@end
