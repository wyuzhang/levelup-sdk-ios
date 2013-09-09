// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class AFHTTPRequestOperation;

/**
 `LUAPIConnection` represents a connection to the LevelUp API. This object is returned by the
 `performRequest:success:failure` method of `LUAPIClient`.
 */
@interface LUAPIConnection : NSObject

/**
 The callback dispatch queue on failure. If `NULL` (default), the main queue is used.
 */
@property (nonatomic, assign) dispatch_queue_t failureCallbackQueue;

/**
 An `NSOperation` for this request.
 */
@property (nonatomic, strong, readonly) NSOperation *operation;

/**
 The callback dispatch queue on success. If `NULL` (default), the main queue is used.
 */
@property (nonatomic, assign) dispatch_queue_t successCallbackQueue;

- (id)initWithAFHTTPRequestOperation:(AFHTTPRequestOperation *)httpRequestOperation;

@end
