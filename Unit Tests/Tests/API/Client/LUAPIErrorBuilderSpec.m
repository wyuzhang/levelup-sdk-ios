#import "LUAPIClient.h"
#import "LUAPIErrorBuilder.h"

SPEC_BEGIN(LUAPIErrorBuilderSpec)

describe(@"LUAPIErrorBuilder", ^{
  describe(@"error:withMessagesFromJSON:", ^{
    it(@"returns a new error with the same domain and code", ^{
      NSError *error = [NSError errorWithDomain:@"TestErrorDomain"
                                           code:0
                                       userInfo:nil];

      NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:nil];

      [[result shouldNot] beIdenticalTo:error];
      [[result.domain should] equal:error.domain];
      [[theValue(result.code) should] equal:theValue(error.code)];
    });

    context(@"when the JSON is nil", ^{
      it(@"keeps the same userInfo", ^{
        NSError *error = [NSError errorWithDomain:@"TestErrorDomain"
                                             code:0
                                         userInfo:@{@"test" : @"value"}];
        NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:nil];

        [[result.userInfo should] equal:error.userInfo];
      });
    });

    context(@"when the JSON is not nil", ^{
      NSError *error = [NSError errorWithDomain:@"TestErrorDomain"
                                           code:0
                                       userInfo:@{@"test" : @"value"}];

      it(@"adds the JSON to the userInfo", ^{
        NSDictionary *JSON = @{@"name" : @"John Doe"};
        NSError *result = [LUAPIErrorBuilder error:error
                              withMessagesFromJSON:JSON];

        [[result.userInfo[@"test"] should] equal:error.userInfo[@"test"]];
        [[result.userInfo[LUAPIFailingJSONResponseErrorKey] should] equal:JSON];
      });

      context(@"when the JSON includes an error_description", ^{
        it(@"adds it to the userInfo", ^{
          NSDictionary *JSON = @{@"error_description" : @"error description message"};
          NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:JSON];

          [[result.userInfo[LUAPIFailingErrorMessageErrorKey] should] equal:JSON[@"error_description"]];
        });
      });

      context(@"when the JSON includes an error", ^{
        it(@"adds it to the userInfo", ^{
          NSDictionary *JSON = @{@"error" : @"error message"};
          NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:JSON];

          [[result.userInfo[LUAPIFailingErrorMessageErrorKey] should] equal:JSON[@"error"]];
        });
      });

      context(@"when the JSON includes an error_description and an error", ^{
        it(@"adds the error_description to the userInfo", ^{
          NSDictionary *JSON = @{@"error" : @"error message", @"error_description" : @"error_description message"};
          NSError *result = [LUAPIErrorBuilder error:error withMessagesFromJSON:JSON];

          [[result.userInfo[LUAPIFailingErrorMessageErrorKey] should] equal:JSON[@"error_description"]];
        });
      });
    });
  });
});

SPEC_END
