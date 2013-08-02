@interface NSRegularExpression (LUAdditions)

- (BOOL)lu_hasMatchesInString:(NSString *)string;
- (NSArray *)lu_matchesInString:(NSString *)string;
- (NSString *)lu_removeMatchesInString:(NSString *)string;

@end
