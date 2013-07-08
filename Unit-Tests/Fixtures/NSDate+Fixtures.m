#import "NSDate+Fixtures.h"
#import "NSDate+StringFormats.h"

@implementation NSDate (Fixtures)

+ (NSDate *)fixture {
  return [self lu_dateFromIso8601DateTimeString:@"2012-12-04T18:10:45-05:00"];
}

@end
