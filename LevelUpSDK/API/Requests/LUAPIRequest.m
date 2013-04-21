#import "LUAPIClient.h"
#import "LUAbstractJSONModelFactory.h"
#import "LUAPIRequest.h"

@implementation LUAPIRequest

#pragma mark - Object Lifecycle Methods

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory {
  return [[self alloc] initWithMethod:method path:path parameters:parameters modelFactory:modelFactory];
}

- (id)initWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters modelFactory:(LUAbstractJSONModelFactory *)modelFactory {
  self = [super init];
  if (self) {
    _modelFactory = modelFactory;
    _method = method;
    _path = path;
    _parameters = parameters;
  }

  return self;
}

#pragma mark - Public Methods

- (NSURLRequest *)urlRequest {
  return [[LUAPIClient sharedClient] requestWithMethod:self.method path:self.path parameters:self.parameters];
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.method) {
    total += [self.method hash] * 11;
  }
  if (self.path) {
    total += [self.path hash] * 13;
  }
  if (self.parameters) {
    total += [[self.parameters description] hash] * 17;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUAPIRequest class]]) {
    LUAPIRequest *otherApiRequest = (LUAPIRequest *)otherObject;

    BOOL methodEqual = ((!otherApiRequest.method && !self.method) ||
                        (otherApiRequest.method && self.method &&
                         [otherApiRequest.method isEqualToString:self.method]));

    BOOL pathEqual = ((!otherApiRequest.path && !self.path) ||
                      (otherApiRequest.path && self.path &&
                       [otherApiRequest.path isEqualToString:self.path]));

    BOOL parametersEqual = ((!otherApiRequest.parameters && !self.parameters) ||
                             (otherApiRequest.parameters && self.parameters &&
                              [otherApiRequest.parameters isEqualToDictionary:self.parameters]));

    return methodEqual && pathEqual && parametersEqual;
  }

  return NO;
}

@end
