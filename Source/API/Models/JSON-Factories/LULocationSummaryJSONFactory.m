#import "LULocation.h"
#import "LULocationSummaries.h"
#import "LULocationSummaryJSONFactory.h"
#import "LUWebLinkParser.h"
#import "NSDate+StringFormats.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationSummaryJSONFactory

- (id)fromJSONObject:(id)JSON httpResponse:(NSHTTPURLResponse *)response {
  id result = [super fromJSONObject:JSON httpResponse:response];

  if (![result isKindOfClass:[NSArray class]]) return nil;

  NSArray *locations = result;

  NSString *linkHeader = [response allHeaderFields][@"Link"];
  LUWebLinkParser *webLink = [[LUWebLinkParser alloc] initWithHeaderValue:linkHeader];
  NSURL *nextPageURL = webLink.nextURL;

  return [[LULocationSummaries alloc] initWithLocations:locations nextPageURL:nextPageURL];
}

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSArray *categoryIDs;

  if ([attributes[@"categories"] isKindOfClass:[NSArray class]]) {
    categoryIDs = attributes[@"categories"];
  }

  NSNumber *latitude = [attributes numberForKey:@"latitude"];
  NSNumber *locationID = [attributes numberForKey:@"id"];
  NSNumber *longitude = [attributes numberForKey:@"longitude"];
  NSNumber *merchantID = [attributes numberForKey:@"merchant_id"];
  NSString *merchantName = [attributes stringForKey:@"merchant_name"];
  BOOL shown = [attributes boolForKey:@"shown"];
  NSDate *updatedAtDate = [NSDate dateFromIso8601DateTimeString:attributes[@"updated_at"]];

  return [[LULocation alloc] initWithCategoryIDs:categoryIDs latitude:latitude locationID:locationID longitude:longitude
                                      merchantID:merchantID merchantName:merchantName shown:shown
                                   updatedAtDate:updatedAtDate];
}

- (NSString *)rootKey {
  return @"location";
}

@end
