// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIError.h"
#import "LUAPIErrorJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUAPIErrorJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *code = [attributes lu_stringForKey:@"code"];
  NSString *message = [attributes lu_stringForKey:@"message"];
  NSString *object = [attributes lu_stringForKey:@"object"];
  NSString *property = [attributes lu_stringForKey:@"property"];

  return [[LUAPIError alloc] initWithCode:code message:message object:object property:property];
}

- (NSString *)rootKey {
  return @"error";
}

@end
