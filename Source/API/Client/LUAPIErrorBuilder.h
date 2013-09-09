// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface LUAPIErrorBuilder : NSObject

+ (NSError *)error:(NSError *)error withMessagesFromJSON:(id)JSON;

@end
