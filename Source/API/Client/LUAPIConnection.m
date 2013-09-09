// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "AFNetworking.h"
#import "LUAPIConnection.h"

@interface LUAPIConnection ()

@property (nonatomic, strong) AFHTTPRequestOperation *httpRequestOperation;

@end

@implementation LUAPIConnection

- (id)initWithAFHTTPRequestOperation:(AFHTTPRequestOperation *)httpRequestOperation {
  self = [super init];
  if (!self) return nil;

  _httpRequestOperation = httpRequestOperation;

  return self;
}

- (NSOperation *)operation {
  return self.httpRequestOperation;
}

- (dispatch_queue_t)failureCallbackQueue {
  return self.httpRequestOperation.failureCallbackQueue;
}

- (dispatch_queue_t)successCallbackQueue {
  return self.httpRequestOperation.successCallbackQueue;
}

- (void)setFailureCallbackQueue:(dispatch_queue_t)failureCallbackQueue {
  self.httpRequestOperation.failureCallbackQueue = failureCallbackQueue;
}

- (void)setSuccessCallbackQueue:(dispatch_queue_t)successCallbackQueue {
  self.httpRequestOperation.successCallbackQueue = successCallbackQueue;
}

@end
