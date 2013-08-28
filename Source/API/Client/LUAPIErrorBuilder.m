#import "LUAPIClient.h"
#import "LUAPIErrorBuilder.h"
#import "LUAPIErrorJSONFactory.h"
#import "LUConstants.h"

@interface LUAPIErrorBuilder ()

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id JSON;

@end

@implementation LUAPIErrorBuilder

#pragma mark - Public Methods

+ (NSError *)error:(NSError *)error withMessagesFromJSON:(id)JSON {
  return [[[self alloc] initWithError:error withMessagesFromJSON:JSON] buildError];
}

#pragma mark - Private Methods (Object Creation)

- (id)initWithError:(NSError *)error withMessagesFromJSON:(id)JSON {
  self = [super init];
  if (!self) return nil;

  _error = error;
  _JSON = JSON;

  return self;
}

#pragma mark - Private Methods (Error Building)

- (NSArray *)apiErrors {
  id errors = [[LUAPIErrorJSONFactory factory] fromJSONObject:self.JSON];

  if (![errors isKindOfClass:[NSArray class]]) return nil;

  return errors;
}

- (NSError *)buildError {
  return [NSError errorWithDomain:LUAPIErrorDomain
                             code:[self code]
                         userInfo:[self userInfo]];
}

- (LUAPIErrorCode)code {
  if ([LUAPIClient sharedClient].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
    return LUAPIErrorNetwork;
  }

  if ([self.error.domain isEqualToString:NSCocoaErrorDomain] && self.error.code == NSPropertyListReadCorruptError) {
    return LUAPIErrorParsing;
  }

  NSHTTPURLResponse *response = [self response];
  if (!response) return LUAPIErrorServer;

  switch (response.statusCode) {
    case 401:
      return LUAPIErrorLoginRequired;

    case 404:
      return LUAPIErrorNotFound;

    case 501:
      return LUAPIErrorUpgrade;

    case 503:
      return LUAPIErrorMaintenance;

    default:
      return LUAPIErrorServer;
  }
}

- (NSString *)errorMessage {
  if ([self apiErrors]) {
    return [[self apiErrors][0] message];
  }

  if (!self.JSON || ![self.JSON isKindOfClass:[NSDictionary class]]) return nil;

  NSDictionary *responseDict = (NSDictionary *)self.JSON;

  if (responseDict[@"error_description"]) {
    return responseDict[@"error_description"];
  } else if (responseDict[@"error"]) {
    return responseDict[@"error"];
  }

  return nil;
}

- (NSString *)localizedDescription {
  if ([self errorMessage].length > 0) {
    return [self errorMessage];
  }

  switch ([self code]) {
    case LUAPIErrorLoginRequired:
      return @"Authentication session has expired. Please log in again.";

    case LUAPIErrorMaintenance:
      return @"The server is currently down for maintenance. Please try again later.";

    case LUAPIErrorNotFound:
      return @"The server was not able to find the specified resource.";

    case LUAPIErrorNetwork:
      return @"No Internet connection available.";

    case LUAPIErrorParsing:
      return @"Unexpected response from the server.";

    case LUAPIErrorUpgrade:
      return @"This version of the SDK is out of date.";

    case LUAPIErrorServer:
    default:
      return @"There was a problem connecting to the server.";
  }
}

- (NSHTTPURLResponse *)response {
  id response = self.error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];

  if (![response isKindOfClass:[NSHTTPURLResponse class]]) return nil;

  return response;
}

- (NSDictionary *)userInfo {
  NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:@{
    NSLocalizedDescriptionKey : [self localizedDescription],
    LUAPIErrorKeyOriginalError : self.error
  }];

  if (self.JSON) {
    userInfo[LUAPIErrorKeyJSONResponse] = self.JSON;
  }

  if ([self errorMessage]) {
    userInfo[LUAPIErrorKeyErrorMessage] = [self errorMessage];
  }

  if ([self response]) {
    userInfo[LUAPIErrorKeyURLResponse] = [self response];
  }

  if ([self apiErrors]) {
    userInfo[LUAPIErrorKeyAPIErrors] = [self apiErrors];
  }

  return userInfo;
}

@end
