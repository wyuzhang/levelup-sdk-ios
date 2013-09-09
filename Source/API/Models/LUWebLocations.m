// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUWebLocations.h"

@interface LUWebLocations ()

@property (nonatomic, strong) NSString *facebookAddress;
@property (nonatomic, strong) NSString *menuAddress;
@property (nonatomic, strong) NSString *newsletterAddress;
@property (nonatomic, strong) NSString *opentableAddress;
@property (nonatomic, strong) NSString *twitterAddress;
@property (nonatomic, strong) NSString *yelpAddress;

@end

@implementation LUWebLocations

#pragma mark - Creation Methods

- (id)initWithFacebookAddress:(NSString *)facebook
                  menuAddress:(NSString *)menu
            newsletterAddress:(NSString *)newsletter
             opentableAddress:(NSString *)opentable
               twitterAddress:(NSString *)twitter
                  yelpAddress:(NSString *)yelp {
  self = [super init];

  _facebookAddress = facebook;
  _menuAddress = menu;
  _newsletterAddress = newsletter;
  _opentableAddress = opentable;
  _twitterAddress = twitter;
  _yelpAddress = yelp;

  return self;
}

#pragma mark - Public Methods

- (NSURL *)facebookURL {
  return [NSURL URLWithString:self.facebookAddress];
}

- (NSURL *)menuURL {
  return [NSURL URLWithString:self.menuAddress];
}

- (NSURL *)newsletterURL {
  return [NSURL URLWithString:self.newsletterAddress];
}

- (NSURL *)opentableURL {
  return [NSURL URLWithString:self.opentableAddress];
}

- (NSURL *)twitterURL {
  return [NSURL URLWithString:self.twitterAddress];
}

- (NSURL *)yelpURL {
  return [NSURL URLWithString:self.yelpAddress];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUWebLocation [facebookAddress=%@, menuAddress=%@, newsletterAddress=%@, opentableAddress=%@, twitterAddress=%@, yelpAddress=%@", self.facebookAddress, self.menuAddress, self.newsletterAddress, self.opentableAddress, self.twitterAddress, self.yelpAddress];
}

@end
