#import "LUCategory.h"
#import "LUCategoryModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCategoryModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"category"]) {
    attributes = attributes[@"category"];
  }

  LUCategory *category = [[LUCategory alloc] init];
  category.categoryID = [attributes numberForKey:@"id"];
  category.name = [attributes stringForKey:@"name"];

  return category;
}

@end
