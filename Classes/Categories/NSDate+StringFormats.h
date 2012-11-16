#import <Foundation/Foundation.h>

@interface NSDate (StringFormats)

+ (NSDate *)dateFromIso8601DateOnlyString:(NSString *)dateString;
+ (NSDate *)dateFromIso8601DateTimeString:(NSString *)dateString;
- (NSString *)iso8601DateOnlyString;
- (NSString *)iso8601DateTimeString;
- (NSString *)longDateTimeString;
- (NSString *)shortDateOnlyString;
- (NSString *)shorterDateOnlyString;

@end
