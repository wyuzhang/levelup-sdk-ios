// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULocation.h"
#import "LULocationSummaryJSONFactory.h"
#import "NSDate+StringFormats.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationSummaryJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSArray *categoryIDs;

  if ([attributes[@"categories"] isKindOfClass:[NSArray class]]) {
    categoryIDs = attributes[@"categories"];
  }

  NSNumber *latitude = [attributes lu_numberForKey:@"latitude"];
  NSNumber *locationID = [attributes lu_numberForKey:@"id"];
  NSNumber *longitude = [attributes lu_numberForKey:@"longitude"];
  NSNumber *merchantID = [attributes lu_numberForKey:@"merchant_id"];
  NSString *merchantName = [attributes lu_stringForKey:@"merchant_name"];
  BOOL shown = [attributes lu_boolForKey:@"shown"];
  NSDate *updatedAtDate = [NSDate lu_dateFromIso8601DateTimeString:attributes[@"updated_at"]];

  return [[LULocation alloc] initWithCategoryIDs:categoryIDs latitude:latitude locationID:locationID longitude:longitude
                                      merchantID:merchantID merchantName:merchantName shown:shown
                                   updatedAtDate:updatedAtDate];
}

- (NSString *)rootKey {
  return @"location";
}

@end
