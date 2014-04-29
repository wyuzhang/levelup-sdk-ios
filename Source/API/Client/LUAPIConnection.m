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
  return self.httpRequestOperation.completionQueue;
}

- (dispatch_queue_t)successCallbackQueue {
  return self.httpRequestOperation.completionQueue;
}

- (void)setFailureCallbackQueue:(dispatch_queue_t)failureCallbackQueue {
  self.httpRequestOperation.completionQueue = failureCallbackQueue;
}

- (void)setSuccessCallbackQueue:(dispatch_queue_t)successCallbackQueue {
  self.httpRequestOperation.completionQueue = successCallbackQueue;
}

@end
