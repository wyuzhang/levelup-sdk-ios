#import "LUCategory.h"
#import "LUCategoryJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCategoryJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *categoryID = [attributes lu_numberForKey:@"id"];
  NSString *name = [attributes lu_stringForKey:@"name"];

  return [[LUCategory alloc] initWithCategoryID:categoryID name:name];
}

- (NSString *)rootKey {
  return @"category";
}

@end
