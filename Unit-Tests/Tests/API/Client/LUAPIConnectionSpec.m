// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

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
