#import "LUCauseCategory.h"
#import "LUCauseCategoryJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCauseCategoryJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *causeCategoryID = [attributes lu_numberForKey:@"id"];
  NSString *name = [attributes lu_stringForKey:@"name"];

  return [[LUCauseCategory alloc] initWithCauseCategoryID:causeCategoryID name:name];
}

- (NSString *)rootKey {
  return @"cause_category";
}

@end
