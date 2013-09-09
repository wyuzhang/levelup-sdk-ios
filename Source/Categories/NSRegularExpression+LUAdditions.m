// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

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

- (NSString *)lu_removeMatchesInString:(NSString *)string {
  NSMutableString *mutableString = [string mutableCopy];
  [self replaceMatchesInString:mutableString
                        options:0
                          range:NSMakeRange(0, string.length)
                   withTemplate:@""];

  return [NSString stringWithString:mutableString];
}

@end
