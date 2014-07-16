/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUCampaign.h"
#import "LUMonetaryValue.h"
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(LUCampaignSpec)

describe(@"LUCampaign", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCampaign class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"confirmationText", ^{
    NSString *expectedText = @"This is a test.";
    LUCampaign *campaign = [LUCampaign fixtureWithConfirmationHTML:[NSString stringWithFormat:@"<p>%@</p>", expectedText]
                                                         offerHTML:nil];

    it(@"returns confirmationHTML with HTML stripped out", ^{
      [[[campaign confirmationText] should] equal:expectedText];
    });
  });

  describe(@"imageURL", ^{
    LUCampaign *campaign = [LUCampaign fixtureWithCampaignID:@1];
    NSURL *URL = [NSURL URLWithString:@"http://example.com/path/to/image"];

    beforeEach(^{
      [NSURL stub:@selector(lu_imageURLForCampaignWithID:) andReturn:URL withArguments:@1, nil];
    });

    it(@"returns the URL of the location image request", ^{
      [[[campaign imageURL] should] equal:URL];
    });
  });

  describe(@"offerText", ^{
    NSString *expectedText = @"This is a test.";
    LUCampaign *campaign = [LUCampaign fixtureWithConfirmationHTML:nil
                                                         offerHTML:[NSString stringWithFormat:@"<p>%@</p>", expectedText]];

    it(@"returns offerHTML with HTML stripped out", ^{
      [[[campaign offerText] should] equal:expectedText];
    });
  });
});

SPEC_END
