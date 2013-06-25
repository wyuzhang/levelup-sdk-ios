#import "LUAPIError+Fixtures.h"

@implementation LUAPIError (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"message" : @"error message",
    @"object" : @"user",
    @"property" : @"first_name"
  };
}

+ (NSDictionary *)fullJSONObject2 {
  return @{
    @"message" : @"second message",
    @"object" : @"location",
    @"property" : @"name"
  };
}

@end
