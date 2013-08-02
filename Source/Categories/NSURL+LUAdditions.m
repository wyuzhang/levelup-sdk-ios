#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "NSRegularExpression+LUAdditions.h"
#import "NSURL+LUAdditions.h"

@implementation NSURL (LUAdditions)

NSString * const LUPatternLeadingSlashOptionalVersion = @"^/(v\\d+/)?";

#pragma mark - Public Methods

+ (NSURL *)lu_imageURLForImageWithBase:(NSURL *)baseURL {
  if (!baseURL) return nil;

  NSString *imageURLStringWithParameters = [NSString stringWithFormat:@"%@?%@", [baseURL absoluteString], [self imageQueryString]];
  return [NSURL URLWithString:imageURLStringWithParameters];
}

+ (NSURL *)lu_imageURLForLocationWithID:(NSNumber *)locationID {
  if (!locationID) return nil;

  NSString *path = [NSString stringWithFormat:@"%@/locations/%@/image?%@", LUAPIVersion14, [locationID stringValue],
                    [self imageQueryString]];

  return [NSURL URLWithString:path relativeToURL:[LUAPIClient sharedClient].baseURL];
}

- (NSString *)lu_pathAndQueryWithoutAPIVersion {
  NSString *pathWithQuery = [self pathWithQuery];

  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:LUPatternLeadingSlashOptionalVersion
                                                                         options:0
                                                                           error:NULL];
  return [regex lu_removeMatchesInString:pathWithQuery];
}

#pragma mark - Private Methods

+ (NSString *)imageQueryString {
  NSDictionary *parameters = @{
    @"width" : @320,
    @"height" : @212,
    @"density" : @((int)[UIScreen mainScreen].scale)
  };

  return AFQueryStringFromParametersWithEncoding(parameters, NSUTF8StringEncoding);
}

- (NSString *)pathWithQuery {
  if ([self query].length > 0) {
    return [NSString stringWithFormat:@"%@?%@", [self path], [self query]];
  } else {
    return [self path];
  }
}

@end
