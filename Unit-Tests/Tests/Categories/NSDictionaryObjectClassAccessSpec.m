#import "NSDate+StringFormats.h"
#import "NSDictionary+ObjectClassAccess.h"

SPEC_BEGIN(NSDictionaryObjectClassAccessSpec)

describe(@"NSDictionary", ^{
  // Public Methods

  describe(@"lu_boolForKey:", ^{
    NSDictionary *dict = @{
      @"0" : @"0",
      @"1" : @"1",
      @1 : @1,
      @2 : @2
    };

    it(@"returns NO for '0' and YES for '1'", ^{
      [[theValue([dict lu_boolForKey:@"0"]) should] beNo];
      [[theValue([dict lu_boolForKey:@"1"]) should] beYes];
    });

    it(@"returns NO for 0 and YES for 1", ^{
      [[theValue([dict lu_boolForKey:@0]) should] beNo];
      [[theValue([dict lu_boolForKey:@1]) should] beYes];
    });

    it(@"returns NO for anything other a string or number", ^{
      NSDictionary *dictionary = @{@"array" : @[]};

      [[theValue([dictionary lu_boolForKey:@"array"]) should] beNo];
      [[theValue([dictionary lu_boolForKey:@"nil"]) should] beNo];
    });
  });

  describe(@"lu_dateForKey:", ^{
    context(@"when the value is an ISO 8601 date string", ^{
      NSDictionary *dictionary = @{@"date" : @"2012-12-04T18:10:45-05:00"};

      it(@"returns the string converted to an NSDate", ^{
        NSDate *expected = [NSDate lu_dateFromIso8601DateTimeString:dictionary[@"date"]];

        [[[dictionary lu_dateForKey:@"date"] should] equal:expected];
      });
    });

    context(@"when the value does not convert into a date", ^{
      NSDictionary *dictionary = @{@"not date" : @"not a date"};

      it(@"returns nil", ^{
        [[dictionary lu_dateForKey:@"not date"] shouldBeNil];
      });
    });

    context(@"when the value is not a string", ^{
      NSDictionary *dictionary = @{@"not date" : @0};

      it(@"returns nil", ^{
        [[dictionary lu_dateForKey:@"not date"] shouldBeNil];
      });
    });
  });

  describe(@"lu_dictionaryForKey:", ^{
    context(@"when the value is a dictionary", ^{
      NSDictionary *dictionary = @{@"dict" : @{@"another" : @"dictionary"}};

      it(@"returns the dictionary", ^{
        [[[dictionary lu_dictionaryForKey:@"dict"] should] equal:dictionary[@"dict"]];
      });
    });

    context(@"when the value is not a dictionary", ^{
      NSDictionary *dictionary = @{@"not dictionary" : @"a string"};

      it(@"returns nil", ^{
        [[dictionary lu_dictionaryForKey:@"not dictionary"] shouldBeNil];
      });
    });

    context(@"when the value is a non-number string", ^{
      NSDictionary *dictionary = @{@"not number" : @"string"};

      it(@"returns nil", ^{
        [[dictionary lu_dictionaryForKey:@"not number"] shouldBeNil];
      });
    });
  });

  describe(@"lu_floatForKey:", ^{
    context(@"when the value is a float as a string", ^{
      NSDictionary *dictionary = @{@"float" : @"1.5"};

      it(@"returns the string converted to a float", ^{
        [[theValue([dictionary lu_floatForKey:@"float"]) should] equal:theValue(1.5f)];
      });
    });

    context(@"when the value is a number", ^{
      NSDictionary *dictionary = @{@"float" : @1.5};

      it(@"the number as a float", ^{
        [[theValue([dictionary lu_floatForKey:@"float"]) should] equal:theValue(1.5f)];
      });
    });

    context(@"when the value does not convert to a float", ^{
      NSDictionary *dictionary = @{@"not float" : @"string"};

      it(@"returns 0.0f", ^{
        [[theValue([dictionary lu_floatForKey:@"not float"]) should] equal:theValue(0.0f)];
      });
    });

    context(@"when the value is not a string or a number", ^{
      NSDictionary *dictionary = @{@"not float" : @[]};

      it(@"returns 0.0f", ^{
        [[theValue([dictionary lu_floatForKey:@"not float"]) should] equal:theValue(0.0f)];
      });
    });
  });

  describe(@"lu_numberForKey:", ^{
    context(@"when the value is a number", ^{
      NSDictionary *dictionary = @{@"number" : @1};

      it(@"returns the number", ^{
        [[[dictionary lu_numberForKey:@"number"] should] equal:@1];
      });
    });

    context(@"when the value is a number as a string", ^{
      NSDictionary *dictionary = @{@"number" : @"1"};

      it(@"returns the string converted to a number", ^{
        [[[dictionary lu_numberForKey:@"number"] should] equal:@1];
      });
    });

    context(@"when the value is a non-number string", ^{
      NSDictionary *dictionary = @{@"not number" : @"string"};

      it(@"returns nil", ^{
        [[dictionary lu_numberForKey:@"not number"] shouldBeNil];
      });
    });
  });

  describe(@"lu_stringForKey:", ^{
    context(@"when the value is a string", ^{
      NSDictionary *dictionary = @{@"a string" : @"string"};

      it(@"returns the string", ^{
        [[[dictionary lu_stringForKey:@"a string"] should] equal:@"string"];
      });
    });

    context(@"when the value is not a string", ^{
      NSDictionary *dictionary = @{@"not a string" : @0};

      it(@"returns nil", ^{
        [[dictionary lu_stringForKey:@"not a string"] shouldBeNil];
      });
    });

    context(@"when the value is an empty string", ^{
      NSDictionary *dictionary = @{@"empty string" : @""};

      it(@"returns nil", ^{
        [[dictionary lu_stringForKey:@"empty string"] shouldBeNil];
      });
    });
  });

  describe(@"lu_URLForKey:", ^{
    context(@"when the value is a URL", ^{
      NSDictionary *dictionary = @{@"url" : @"http://example.com"};

      it(@"returns the URL as an NSURL", ^{
        [[[dictionary lu_URLForKey:@"url"] should] equal:[NSURL URLWithString:dictionary[@"url"]]];
      });
    });

    context(@"when the value is a not URL", ^{
      NSDictionary *dictionary = @{@"not url" : @"bad url"};

      it(@"returns nil", ^{
        [[dictionary lu_URLForKey:@"not url"] shouldBeNil];
      });
    });
  });
});

SPEC_END
