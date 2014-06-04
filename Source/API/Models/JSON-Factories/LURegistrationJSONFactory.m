// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LURegistration.h"
#import "LURegistrationJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LURegistrationJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *appName = [attributes lu_stringForKey:@"app_name"];
  BOOL facebook = [attributes lu_boolForKey:@"facebook"];
  NSString *registrationDescription = [attributes lu_stringForKey:@"description"];

  return [[LURegistration alloc] initWithAppName:appName facebook:facebook registrationDescription:registrationDescription];
}

- (NSString *)rootKey {
  return @"registration";
}

@end
