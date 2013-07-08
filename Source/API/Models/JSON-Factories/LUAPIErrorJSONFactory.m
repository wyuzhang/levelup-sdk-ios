#import "LUAPIError.h"
#import "LUAPIErrorJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUAPIErrorJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *message = [attributes lu_stringForKey:@"message"];
  NSString *object = [attributes lu_stringForKey:@"object"];
  NSString *property = [attributes lu_stringForKey:@"property"];

  return [[LUAPIError alloc] initWithMessage:message object:object property:property];
}

- (NSString *)rootKey {
  return @"error";
}

@end
