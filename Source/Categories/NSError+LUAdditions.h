// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUConstants.h"

@interface NSError (LUAdditions)

+ (NSError *)lu_deepLinkAuthErrorWithCode:(LUDeepLinkAuthErrorCode)code description:(NSString *)description;

@end
