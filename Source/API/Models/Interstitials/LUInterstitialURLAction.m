// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUInterstitialURLAction.h"

@implementation LUInterstitialURLAction

#pragma mark - Creation

- (id)initWithURL:(NSURL *)URL {
  self = [super init];
  if (!self) return nil;

  _URL = URL;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUInterstitialURLAction [address=%p, URL=%@]", self, self.URL];
}

@end
