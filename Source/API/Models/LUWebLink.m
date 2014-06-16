// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUWebLink.h"
#import "NSURL+LUAdditions.h"

@implementation LUWebLink

#pragma mark - Creation

- (id)initWithDeepLinkURL:(NSURL *)deepLinkURL title:(NSString *)title
            webLinkTypeID:(NSNumber *)webLinkTypeID webURL:(NSURL *)webURL {
  self = [super init];
  if (!self) return nil;

  _deepLinkURL = deepLinkURL;
  _title = title;
  _webLinkTypeID = webLinkTypeID;
  _webURL = webURL;

  return self;
}

#pragma mark - Public Methods

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForWebLinkTypeWithID:self.webLinkTypeID];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUWebLink [address=%p, deepLinkURL=%@, title=%@, webLinkTypeID=%@, webURL=%@]",
          self, self.deepLinkURL, self.title, self.webLinkTypeID, self.webURL];
}

@end
