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
    context(@"when the value is LUCampaignRepresentationTypeBasicV1", ^{
      it(@"returns 'basic_v1'", ^{
        NSString *result = [transformer transformedValue:@(LUCampaignRepresentationTypeBasicV1)];
        [[result should] equal:@"basic_v1"];
      });
    });

    context(@"when the value is LUCampaignRepresentationTypeSpendBasedLoyaltyV1", ^{
      it(@"returns 'spend_based_loyalty_v1'", ^{
        NSString *result = [transformer transformedValue:@(LUCampaignRepresentationTypeSpendBasedLoyaltyV1)];
        [[result should] equal:@"spend_based_loyalty_v1"];
      });
    });

    context(@"when the value is LUCampaignRepresentationTypeVisitBasedLoyaltyV1", ^{
      it(@"returns 'visit_based_loyalty_v1'", ^{
        NSString *result = [transformer transformedValue:@(LUCampaignRepresentationTypeVisitBasedLoyaltyV1)];
        [[result should] equal:@"visit_based_loyalty_v1"];
      });
    });
  });

  describe(@"reverseTransformedValue:", ^{
    context(@"when the value is 'basic_v1'", ^{
      it(@"returns LUCampaignRepresentationTypeBasicV1 as an NSNumber", ^{
        NSNumber *result = [transformer reverseTransformedValue:@"basic_v1"];
        [[result should] equal:@(LUCampaignRepresentationTypeBasicV1)];
      });
    });

    context(@"when the value is 'spend_based_loyalty_v1'", ^{
      it(@"returns LUCampaignRepresentationTypeSpendBasedLoyaltyV1 as an NSNumber", ^{
        NSNumber *result = [transformer reverseTransformedValue:@"spend_based_loyalty_v1"];
        [[result should] equal:@(LUCampaignRepresentationTypeSpendBasedLoyaltyV1)];
      });
    });

    context(@"when the value is 'visit_based_loyalty_v1'", ^{
      it(@"returns LUCampaignRepresentationTypeVisitBasedLoyaltyV1 as an NSNumber", ^{
        NSNumber *result = [transformer reverseTransformedValue:@"visit_based_loyalty_v1"];
        [[result should] equal:@(LUCampaignRepresentationTypeVisitBasedLoyaltyV1)];
      });
    });
  });
});

SPEC_END
