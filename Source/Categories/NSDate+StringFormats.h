@interface NSDate (StringFormats)

+ (NSDate *)dateFromIso8601DateTimeString:(NSString *)dateString;
+ (NSDateFormatter *)iso8601DateTimeFormatter;
- (NSString *)iso8601DateTimeString;

@end
