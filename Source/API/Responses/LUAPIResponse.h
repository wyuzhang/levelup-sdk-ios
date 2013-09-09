// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface LUAPIResponse : NSObject

@property (nonatomic, strong, readonly) NSHTTPURLResponse *HTTPURLResponse;

- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)HTTPURLResponse;
- (NSURL *)nextPageURL;

@end
