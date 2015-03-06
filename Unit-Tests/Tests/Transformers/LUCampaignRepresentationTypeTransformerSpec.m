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

#import "LUCampaignRepresentationTypeTransformer.h"

SPEC_BEGIN(LUCampaignRepresentationTypeTransformerSpec)

describe(@"LUCampaignRepresentationTypeTransformer", ^{
  __block NSValueTransformer *transformer;

  beforeAll(^{
    [NSValueTransformer setValueTransformer:[[LUCampaignRepresentationTypeTransformer alloc] init]
                                    forName:LUCampaignRepresentationTypeTransformerName];
    transformer = [NSValueTransformer valueTransformerForName:LUCampaignRepresentationTypeTransformerName];
  });

  describe(@"transformValue:", ^{
    it(@"returns the proper string", ^{
      NSString *type = [transformer transformedValue:@(LUCampaignRepresentationTypeBasicV1)];
      [[type should] equal:@"basic_v1"];
    });
  });

  describe(@"reverseTransformedValue:", ^{
    it(@"returns an NSNumber representation of the proper enumerated value for the type string", ^{
      NSNumber *type = [transformer reverseTransformedValue:@"basic_v1"];
      [[type should] equal:@(LUCampaignRepresentationTypeBasicV1)];
    });
  });
});

SPEC_END
