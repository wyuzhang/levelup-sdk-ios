// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUWebLink.h"
#import "LUWebLinkJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUWebLinkJSONFactory

#pragma mark - Public Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSURL *deepLinkURL = [attributes lu_URLForKey:@"ios_deeplink_url"];
  NSString *title = [attributes lu_stringForKey:@"title"];
  NSNumber *webLinkTypeID = [attributes lu_numberForKey:@"web_link_type_id"];
  NSURL *webURL = [attributes lu_URLForKey:@"web_url"];

  return [[LUWebLink alloc] initWithDeepLinkURL:deepLinkURL
                                          title:title
                                  webLinkTypeID:webLinkTypeID
                                         webURL:webURL];
}

- (NSString *)rootKey {
  return @"web_link";
}

@end
