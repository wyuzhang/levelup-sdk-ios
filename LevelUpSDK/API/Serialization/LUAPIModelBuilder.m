#import "LUAPIModelBuilder.h"
#import "NSArray+ObjectAccess.h"

@implementation LUAPIModelBuilder

#pragma mark - Public Methods

+ (id)builder {
  return [[self alloc] init];
}

- (id)buildModelFromJSON:(id)JSON {
  if ([JSON isKindOfClass:[NSArray class]]) {
    return [self parseArray:JSON];
  } else if ([JSON isKindOfClass:[NSDictionary class]]) {
    return [self buildModelFromAttributes:JSON];
  } else if (![JSON isEqual:[NSNull null]]) {
    return JSON;
  } else {
    return nil;
  }
}

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                               userInfo:nil];
}

#pragma mark - Private Methods

- (id)parseArray:(NSArray *)array {
  NSMutableArray *parsed = [NSMutableArray array];
  for (id subJSON in array) {
    [parsed addObject:[self buildModelFromJSON:subJSON]];
  }

  return parsed;
}

@end
