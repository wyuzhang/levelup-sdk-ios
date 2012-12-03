#import <Foundation/Foundation.h>

@interface NSDate (StringFormats)

+ (NSDate *)dateFromIso8601DateTimeString:(NSString *)dateString;
- (NSString *)iso8601DateTimeString;

@end
