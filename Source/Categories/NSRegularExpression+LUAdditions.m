#import "NSRegularExpression+LUAdditions.h"

@implementation NSRegularExpression (LUAdditions)

- (BOOL)lu_hasMatchesInString:(NSString *)string {
  return [self numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)] > 0;
}

- (NSArray *)lu_matchesInString:(NSString *)string {
  return [self matchesInString:string
                       options:0
                         range:NSMakeRange(0, string.length)];
}

@end
