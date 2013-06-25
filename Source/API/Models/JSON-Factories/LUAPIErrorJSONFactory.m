#import "LUAPIError.h"
#import "LUAPIErrorJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUAPIErrorJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *message = [attributes stringForKey:@"message"];
  NSString *object = [attributes stringForKey:@"object"];
  NSString *property = [attributes stringForKey:@"property"];

  return [[LUAPIError alloc] initWithMessage:message object:object property:property];
}

- (NSString *)rootKey {
  return @"error";
}

@end
