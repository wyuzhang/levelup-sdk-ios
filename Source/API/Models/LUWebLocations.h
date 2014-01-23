// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

@interface LUWebLocations : LUAPIModel

- (id)initWithFacebookAddress:(NSString *)facebook
               foodlerAddress:(NSString *)foodler
                  menuAddress:(NSString *)menu
            newsletterAddress:(NSString *)newsletter
             opentableAddress:(NSString *)opentable
               twitterAddress:(NSString *)twitter
                  yelpAddress:(NSString *)yelp;

- (NSURL *)facebookURL;
- (NSURL *)foodlerURL;
- (NSURL *)menuURL;
- (NSURL *)newsletterURL;
- (NSURL *)opentableURL;
- (NSURL *)twitterURL;
- (NSURL *)yelpURL;

@end
