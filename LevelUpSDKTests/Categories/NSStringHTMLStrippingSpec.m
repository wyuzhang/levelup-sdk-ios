#import "NSString+HTMLStripping.h"

SPEC_BEGIN(NSStringHTMLStrippingSpec)

describe(@"NSString", ^{
  // Public Methods

  describe(@"stringByStrippingHTML", ^{
    it(@"returns the string with HTML stripped out", ^{
      NSString *htmlString = @"<p>A test string with a <a href=\"#\">link</a>.</p>";
      NSString *expected = @"A test string with a link.";

      [[[htmlString stringByStrippingHTML] should] equal:expected];
    });
  });
});

SPEC_END
