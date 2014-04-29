// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "AFNetworking.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "NSRegularExpression+LUAdditions.h"
#import "NSURL+LUAdditions.h"
#import <UIKit/UIKit.h>

@implementation NSURL (LUAdditions)

NSString * const LUPatternLeadingSlashOptionalVersion = @"^/(v\\d+/)?";

#pragma mark - Public Methods

+ (NSURL *)lu_imageURLForCampaignWithID:(NSNumber *)campaignID {
  if (!campaignID) return nil;

  NSString *path = [NSString stringWithFormat:@"campaigns/%@/image", [campaignID stringValue]];
  return [self imageURLForPath:path];
}

+ (NSURL *)lu_imageURLForImageWithBase:(NSURL *)baseURL {
  if (!baseURL) return nil;

  NSString *imageURLStringWithParameters = [NSString stringWithFormat:@"%@?%@", [baseURL absoluteString], [self imageQueryString]];
  return [NSURL URLWithString:imageURLStringWithParameters];
}

+ (NSURL *)lu_imageURLForLocationWithID:(NSNumber *)locationID {
  if (!locationID) return nil;

  NSString *path = [NSString stringWithFormat:@"locations/%@/image", [locationID stringValue]];
  return [self imageURLForPath:path];
}

+ (NSURL *)lu_URLWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path queryParameters:(NSDictionary *)queryParameters {
  NSString *URLString = [NSString stringWithFormat:@"%@://%@%@", scheme, host, path];

  return [[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:queryParameters error:nil] URL];
}

- (NSString *)lu_pathAndQueryWithoutAPIVersion {
  NSString *pathWithQuery = [self pathWithQuery];

  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:LUPatternLeadingSlashOptionalVersion
                                                                         options:0
                                                                           error:NULL];
  return [regex lu_removeMatchesInString:pathWithQuery];
}

- (NSDictionary *)lu_queryDictionary {
  NSMutableDictionary *result = [NSMutableDictionary dictionary];
  NSArray *parts = [[self query] componentsSeparatedByString:@"&"];

  for (NSString *part in parts) {
    if ([part length] == 0) {
      continue;
    }

    NSRange index = [part rangeOfString:@"="];
    NSString *key;
    NSString *value;

    if (index.location == NSNotFound) {
      key = part;
      value = @"";
    } else {
      key = [part substringToIndex:index.location];
      value = [part substringFromIndex:index.location + index.length];
    }

    key = [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    if ([key hasSuffix:@"[]"]) {
      key = [key substringToIndex:key.length - 2];

      NSMutableArray *valueArray;
      if ([result[key] isKindOfClass:[NSMutableArray class]]) {
        valueArray = result[key];
      } else {
        valueArray = [NSMutableArray array];
        result[key] = valueArray;
      }

      [valueArray addObject:value];
    } else {
      result[key] = value;
    }
  }

  return result;
}

#pragma mark - Private Methods

+ (NSString *)imageQueryString {
  return [NSString stringWithFormat:@"density=%d&height=%d&width=%d", (int)[UIScreen mainScreen].scale, 212, 320];
}

+ (NSURL *)imageURLForPath:(NSString *)path {
  NSString *fullPath = [NSString stringWithFormat:@"%@/%@?%@", LUAPIVersion14, path, [self imageQueryString]];

  return [NSURL URLWithString:fullPath relativeToURL:[LUAPIClient sharedClient].baseURL];
}

- (NSString *)pathWithQuery {
  if ([self query].length > 0) {
    return [NSString stringWithFormat:@"%@?%@", [self path], [self query]];
  } else {
    return [self path];
  }
}

@end
