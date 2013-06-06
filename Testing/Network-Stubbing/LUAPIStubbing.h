@class LUAPIStub;

@interface LUAPIStubbing : NSObject

+ (instancetype)sharedInstance;

- (void)addStub:(LUAPIStub *)stub;
- (void)clearStubs;
- (void)disableNetConnect;
- (void)raiseOnUnexpectedRequest:(BOOL)raiseOnUnexpectedRequest;

@end
