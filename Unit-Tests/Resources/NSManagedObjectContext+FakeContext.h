// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (FakeContext)

+ (NSManagedObjectContext *)fakeContext;

@end
