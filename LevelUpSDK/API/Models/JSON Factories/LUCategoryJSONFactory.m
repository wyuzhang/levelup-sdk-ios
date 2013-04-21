#import "LUCategory.h"
#import "LUCategoryJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCategoryJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *categoryID = [attributes numberForKey:@"id"];
  NSString *name = [attributes stringForKey:@"name"];

  return [[LUCategory alloc] initWithCategoryID:categoryID name:name];
}

- (NSString *)rootKey {
  return @"category";
}

@end
