// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

@interface LUWebLocations : LUAPIModel

- (id)initWithFacebookAddress:(NSString *)facebook
                  menuAddress:(NSString *)menu
            newsletterAddress:(NSString *)newsletter
             opentableAddress:(NSString *)opentable
               twitterAddress:(NSString *)twitter
                  yelpAddress:(NSString *)yelp;

- (NSURL *)facebookURL;
- (NSURL *)menuURL;
- (NSURL *)newsletterURL;
- (NSURL *)opentableURL;
- (NSURL *)twitterURL;
- (NSURL *)yelpURL;

@end
