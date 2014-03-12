// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAbstractJSONModelFactory.h"

SPEC_BEGIN(LUAbstractJSONModelFactorySpec)

describe(@"LUAbstractJSONModelFactory", ^{
  NSDictionary *jsonAttributes = @{
    @"key1" : @1,
    @"key2" : @2
  };

  __block LUAbstractJSONModelFactory *modelFactory;

  beforeEach(^{
    modelFactory = [[LUAbstractJSONModelFactory alloc] init];
  });

  // Public Methods

  describe(@"createFromAttributes:", ^{
    it(@"throws an exception", ^{
      [[theBlock(^{ [modelFactory fromDictionary:@{}]; }) should] raise];
    });
  });

  describe(@"fromArray:", ^{
    it(@"returns an array with each JSON element parsed", ^{
      NSArray *jsonArray = @[@1, @2];

      id element1 = [KWMock mock];
      id element2 = [KWMock mock];

      [modelFactory stub:@selector(fromJSONObject:) andReturn:element1 withArguments:jsonArray[0], nil];
      [modelFactory stub:@selector(fromJSONObject:) andReturn:element2 withArguments:jsonArray[1], nil];

      [[[modelFactory fromArray:jsonArray] should] equal:@[element1, element2]];
    });
  });

  describe(@"fromDictionary:", ^{
    beforeEach(^{
      // For testing, stub createFromAttributes: to return the description of its argument
      [modelFactory stub:@selector(createFromAttributes:) withBlock:^(NSArray *params) {
        return [params[0] description];
      }];
    });

    it(@"returns a parsed dictionary", ^{
      [[[modelFactory fromJSONObject:jsonAttributes] should] equal:[jsonAttributes description]];
    });

    context(@"when the rootKey is set", ^{
      NSString *rootKey = @"root";

      beforeEach(^{
        [modelFactory stub:@selector(rootKey) andReturn:rootKey];
      });

      context(@"when the JSON dictionary has a single key equal to the root key", ^{
        context(@"and the value is also a dictionary", ^{
          NSDictionary *jsonDictionary = @{rootKey : jsonAttributes};

          it(@"returns the parsed subdictionary", ^{
            id parsedSubJsonDictionary = [jsonAttributes description];

            [[[modelFactory fromJSONObject:jsonDictionary] should] equal:parsedSubJsonDictionary];
          });
        });

        context(@"but the root's value is not a dictionary", ^{
          NSDictionary *jsonDictionary = @{rootKey : @"value"};

          it(@"returns the entire dictionary parsed", ^{
            id parsedDictionary = [jsonDictionary description];

            [[[modelFactory fromJSONObject:jsonDictionary] should] equal:parsedDictionary];
          });
        });
      });

      context(@"when the JSON dictionary has a key other than the root key", ^{
        NSDictionary *jsonDictionary = @{rootKey : jsonAttributes, @"another key" : @1};

        it(@"returns the entire dictionary parsed", ^{
          id parsedDictionary = [jsonDictionary description];

          [[[modelFactory fromJSONObject:jsonDictionary] should] equal:parsedDictionary];
        });
      });
    });
  });

  describe(@"fromJSON:", ^{
    context(@"when given something other than an array or dictionary", ^{
      it(@"returns nil", ^{
        id object = [[NSObject alloc] init];
        [[modelFactory fromJSONObject:object] shouldBeNil];
      });
    });

    context(@"when given an array", ^{
      NSArray *jsonArray = @[jsonAttributes];

      it(@"parses as an array", ^{
        id parsedArray = [KWMock mock];
        [modelFactory stub:@selector(fromArray:) andReturn:parsedArray withArguments:jsonArray, nil];

        [[[modelFactory fromJSONObject:jsonArray] should] equal:parsedArray];
      });
    });

    context(@"when given a dictionary", ^{
      it(@"parses as a dictionary", ^{
        id parsedDictionary = [KWMock mock];
        [modelFactory stub:@selector(fromDictionary:) andReturn:parsedDictionary withArguments:jsonAttributes, nil];

        [[[modelFactory fromJSONObject:jsonAttributes] should] equal:parsedDictionary];
      });
    });
  });
});

SPEC_END
