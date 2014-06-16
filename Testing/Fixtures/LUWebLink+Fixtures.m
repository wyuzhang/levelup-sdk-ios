// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUWebLink+Fixtures.h"

@implementation LUWebLink (Fixtures)

+ (LUWebLink *)fixture {
  return [[LUWebLink alloc] initWithDeepLinkURL:[NSURL URLWithString:@"example://path/to/1"]
                                          title:@"Website"
                                  webLinkTypeID:@1
                                         webURL:[NSURL URLWithString:@"http://example.com"]];
}

@end
