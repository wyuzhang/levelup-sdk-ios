@interface NSRegularExpression (LUAdditions)

- (BOOL)lu_hasMatchesInString:(NSString *)string;
- (NSArray *)lu_matchesInString:(NSString *)string;

@end
