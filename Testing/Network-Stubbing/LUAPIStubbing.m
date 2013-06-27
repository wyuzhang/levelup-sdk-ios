#import "LUAPIStub.h"
#import "LUAPIStubbing.h"
#import "LUConstants.h"
#import "Kiwi.h"
#import <OHHTTPStubs/OHHTTPStubs.h>

@interface LUAPIStubbing ()

@property (nonatomic, assign) BOOL raiseOnUnexpectedRequest;
@property (nonatomic, strong) NSMutableArray *stubs;

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

  _stubs = [NSMutableArray array];

  return self;
}

- (void)clearStubs {
  [self.stubs removeAllObjects];

  [OHHTTPStubs removeAllRequestHandlers];
  [OHHTTPStubs setEnabled:NO];

  [NSDate clearStubs];
}

- (void)addStub:(LUAPIStub *)stub {
  [self.stubs addObject:stub];

  [OHHTTPStubs setEnabled:YES];
  [OHHTTPStubs removeAllRequestHandlers];

  [OHHTTPStubs addRequestHandler:^OHHTTPStubsResponse *(NSURLRequest *request, BOOL onlyCheck) {
    for (LUAPIStub *stub in [self.stubs reverseObjectEnumerator]) {
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

@end
