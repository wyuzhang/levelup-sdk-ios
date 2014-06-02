// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUKeychainAccess.h"

@interface LUKeychainAccess (StubbingAdditions)

+ (void)clearKeychainData;
+ (NSDictionary *)keychainData;
+ (void)stubKeychainAccess;

@end
