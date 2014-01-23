// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUWebLocations.h"

@interface LUWebLocations ()

@property (nonatomic, copy) NSString *facebookAddress;
@property (nonatomic, copy) NSString *foodlerAddress;
@property (nonatomic, copy) NSString *menuAddress;
@property (nonatomic, copy) NSString *newsletterAddress;
@property (nonatomic, copy) NSString *opentableAddress;
@property (nonatomic, copy) NSString *twitterAddress;
@property (nonatomic, copy) NSString *yelpAddress;

@end

@implementation LUWebLocations

#pragma mark - Creation Methods

- (id)initWithFacebookAddress:(NSString *)facebook foodlerAddress:(NSString *)foodler menuAddress:(NSString *)menu
            newsletterAddress:(NSString *)newsletter opentableAddress:(NSString *)opentable
               twitterAddress:(NSString *)twitter yelpAddress:(NSString *)yelp {
  self = [super init];

  _facebookAddress = facebook;
  _foodlerAddress = foodler;
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

- (NSURL *)foodlerURL {
  return [NSURL URLWithString:self.foodlerAddress];
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
  return [NSString stringWithFormat:@"LUWebLocation [address=%p, facebookAddress=%@, foodlerAddress=%@, menuAddress=%@, newsletterAddress=%@, opentableAddress=%@, twitterAddress=%@, yelpAddress=%@",
          self, self.facebookAddress, self.foodlerAddress, self.menuAddress, self.newsletterAddress,
          self.opentableAddress, self.twitterAddress, self.yelpAddress];
}

@end
