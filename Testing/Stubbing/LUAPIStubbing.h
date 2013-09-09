// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIStub;

@interface LUAPIStubbing : NSObject

+ (instancetype)sharedInstance;

- (void)addStub:(LUAPIStub *)stub;
- (void)clearStubs;
- (void)disableNetConnect;
- (void)raiseOnUnexpectedRequest:(BOOL)raiseOnUnexpectedRequest;

@end
