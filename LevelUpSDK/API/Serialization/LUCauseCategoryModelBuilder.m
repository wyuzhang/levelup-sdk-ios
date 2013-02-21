#import "LUCauseCategory.h"
#import "LUCauseCategoryModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCauseCategoryModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"cause_category"]) {
    attributes = attributes[@"cause_category"];
  }

  LUCauseCategory *causeCategory = [[LUCauseCategory alloc] init];
  causeCategory.causeCategoryID = [attributes numberForKey:@"id"];
  causeCategory.name = [attributes stringForKey:@"name"];

  return causeCategory;
}

@end
