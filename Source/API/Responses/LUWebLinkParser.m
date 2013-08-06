#import "LUWebLinkParser.h"
#import "NSRegularExpression+LUAdditions.h"

@interface LUWebLinkParser ()

@property (nonatomic, copy) NSString *headerValue;

@end

@implementation LUWebLinkParser

#pragma mark - Object Lifecycle

- (id)initWithHeaderValue:(NSString *)headerValue {
  self = [super init];
  if (!self) return nil;

  _headerValue = headerValue;

  return self;
}

#pragma mark - Public Methods

- (NSURL *)nextURL {
  if (!self.headerValue) return nil;

  for (NSDictionary *match in [self linksWithParams]) {
    if ([self containsNextRelationType:match[@"params"]]) {
      return match[@"link"];
    }
  }

  return nil;
}

#pragma mark - Private Methods (Regex matching)

- (BOOL)containsNextRelationType:(NSString *)params {
  return [[self relNextRegex] lu_hasMatchesInString:params];
}

- (NSArray *)linksWithParams {
  NSMutableArray *results = [NSMutableArray array];

  for (NSTextCheckingResult *linkMatch in [[self linkWithParamsRegex] lu_matchesInString:self.headerValue]) {
    NSDictionary *result = [self resultFromMatch:linkMatch];
    if (result) {
      [results addObject:result];
    }
  }

  return results;
}

- (NSDictionary *)resultFromMatch:(NSTextCheckingResult *)match {
  if (match.numberOfRanges < 3) return nil;

  NSRange rangeOfLink = [match rangeAtIndex:1];
  NSRange rangeOfParams = [match rangeAtIndex:2];

  return @{
    @"link" : [NSURL URLWithString:[self.headerValue substringWithRange:rangeOfLink]],
    @"params" : [self.headerValue substringWithRange:rangeOfParams]
  };
}

#pragma mark - Private Methods (Regular Expressions)

- (NSRegularExpression *)linkWithParamsRegex {
  // A link enclosed in "<>", followed by one or more comma separated params
  return [NSRegularExpression regularExpressionWithPattern:@"^<([^>]+)>(?:;([^,]+))+"
                                                   options:NSRegularExpressionCaseInsensitive
                                                     error:nil];
}

- (NSRegularExpression *)relNextRegex {
  return [NSRegularExpression regularExpressionWithPattern:@"rel\\s*=\\s*\"next\""
                                                   options:NSRegularExpressionCaseInsensitive
                                                     error:nil];
}

@end
