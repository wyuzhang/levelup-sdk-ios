@interface NSDate (StringFormats)

+ (NSDate *)lu_dateFromIso8601DateTimeString:(NSString *)dateString;
- (NSString *)lu_iso8601DateTimeString;

@end
