#import "LUAPIClient.h"
#import "LUAPIRequest.h"

@interface LUAPIRequest ()

@property (nonatomic, strong, readwrite) NSURLRequest *urlRequest;

@end

@implementation LUAPIRequest

#pragma mark -
#pragma Creation/Deletion Methods

- (id)initWithURLRequest:(NSURLRequest *)urlRequest {
  self = [super init];
  if (self) {
    _urlRequest = urlRequest;
  }

  return self;
}

#pragma mark -
#pragma mark Public Methods

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters {
  NSMutableDictionary *parametersWithAccessToken = [NSMutableDictionary dictionary];

  if ([LUAPIClient sharedClient].accessToken) {
    parametersWithAccessToken[@"access_token"] = [LUAPIClient sharedClient].accessToken;
  }

  if (parameters) {
    [parametersWithAccessToken addEntriesFromDictionary:parameters];
  }

  NSURLRequest *urlRequest = [[LUAPIClient sharedClient] requestWithMethod:method path:path parameters:parametersWithAccessToken];

  return [[self alloc] initWithURLRequest:urlRequest];
}

- (NSUInteger)hash {
  return self.urlRequest.hash;
}

- (BOOL)isEqual:(id)object {
  return [object isKindOfClass:[self class]] &&
    [[(LUAPIRequest *)object urlRequest] isEqual:self.urlRequest];
}

@end
