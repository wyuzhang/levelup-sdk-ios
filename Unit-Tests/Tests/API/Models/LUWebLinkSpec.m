// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUWebLink.h"
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(LUWebLinkSpec)

describe(@"LUWebLink", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUWebLink class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"imageURL", ^{
    LUWebLink *webLink = [LUWebLink fixture];
    NSURL *URL = [NSURL URLWithString:@"http://example.com/path/to/image"];

    beforeEach(^{
      [NSURL stub:@selector(lu_imageURLForWebLinkTypeWithID:) andReturn:URL withArguments:webLink.webLinkTypeID, nil];
    });

    it(@"returns the URL of the web link type image", ^{
      [[[webLink imageURL] should] equal:URL];
    });
  });
});

SPEC_END
