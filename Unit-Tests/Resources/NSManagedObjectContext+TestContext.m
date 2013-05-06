#import "LUCoreDataStack.h"
#import "NSManagedObjectContext+TestContext.h"

@implementation NSManagedObjectContext (TestContext)

+ (NSManagedObjectContext *)testContext {
  NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];

  NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[[NSBundle bundleForClass:[LUCoreDataStack class]]]];
  managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
  [managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];

  return managedObjectContext;
}

@end
