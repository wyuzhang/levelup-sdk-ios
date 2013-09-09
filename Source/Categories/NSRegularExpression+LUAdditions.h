// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface NSRegularExpression (LUAdditions)

- (BOOL)lu_hasMatchesInString:(NSString *)string;
- (NSArray *)lu_matchesInString:(NSString *)string;
- (NSString *)lu_removeMatchesInString:(NSString *)string;

@end
