#import "NSDate+StringFormats.h"

@implementation NSDate (StringFormats)

+ (NSDateFormatter *)iso8601DateOnlyFormatter {
  NSDateFormatter *iso8601DateOnlyFormatter = [[NSDateFormatter alloc] init];
  [iso8601DateOnlyFormatter setDateFormat:@"yyyy-MM-dd"];

  return iso8601DateOnlyFormatter;
}

+ (NSDateFormatter *)iso8601DateTimeFormatter {
  NSDateFormatter *iso8601DateTimeFormatter = [[NSDateFormatter alloc] init];
  [iso8601DateTimeFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZ"];

  return iso8601DateTimeFormatter;
}

+ (NSDate *)dateFromIso8601DateOnlyString:(NSString *)dateString {
  return [[NSDate iso8601DateOnlyFormatter] dateFromString:dateString];
}

+ (NSDate *)dateFromIso8601DateTimeString:(NSString *)dateString {
  // This tweaking is required because NSDateFormatter doesn't fully support
  // ISO8601. Specifically, it doesn't want time zones with colons, so we strip
  // out the third-to-last character (the colon).
  NSUInteger colonIndex = [dateString length] - 3;
  NSString *finalDateString = dateString;

  if (':' == [finalDateString characterAtIndex:colonIndex]) {
    finalDateString = [finalDateString stringByReplacingCharactersInRange:NSMakeRange(colonIndex, 1) withString:@""];
  }

  return [[NSDate iso8601DateTimeFormatter] dateFromString:finalDateString];
}

- (NSString *)iso8601DateOnlyString {
  return [[NSDate iso8601DateOnlyFormatter] stringFromDate:self];
}

- (NSString *)iso8601DateTimeString {
  return [[NSDate iso8601DateTimeFormatter] stringFromDate:self];
}

- (NSString *)longDateTimeString {
  NSDateFormatter *longDateTimeFormatter = [[NSDateFormatter alloc] init];
  [longDateTimeFormatter setDateStyle:NSDateFormatterMediumStyle];
  [longDateTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
  return [longDateTimeFormatter stringFromDate:self];
}

- (NSString *)shortDateOnlyString {
  NSDateFormatter *shortDateOnlyDateFormatter = [[NSDateFormatter alloc] init];
  [shortDateOnlyDateFormatter setDateStyle:NSDateFormatterShortStyle];
  [shortDateOnlyDateFormatter setTimeStyle:NSDateFormatterNoStyle];
  return [shortDateOnlyDateFormatter stringFromDate:self];
}

- (NSString *)shorterDateOnlyString {
  NSDateFormatter *shorterDateOnlyDateFormatter = [[NSDateFormatter alloc] init];
  [shorterDateOnlyDateFormatter setDateFormat:@"MM/dd"];
  return [shorterDateOnlyDateFormatter stringFromDate:self];
}

@end
