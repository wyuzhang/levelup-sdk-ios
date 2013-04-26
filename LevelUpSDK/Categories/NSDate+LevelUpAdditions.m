#import "NSDate+LevelUpAdditions.h"

@implementation NSDate (LevelUpAdditions)

+ (NSDate *)dateWithYearsSinceNow:(NSInteger)years {
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.year = years;
  NSCalendar *calendar = [NSCalendar currentCalendar];
  return [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
}

@end
