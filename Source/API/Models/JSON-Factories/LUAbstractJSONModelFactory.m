#import "LUAbstractJSONModelFactory.h"
#import "NSArray+LUAdditions.h"

@implementation LUAbstractJSONModelFactory

#pragma mark - Public Methods

+ (instancetype)factory {
  return [[self alloc] init];
}

- (id)createFromAttributes:(NSDictionary *)attributes {
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                               userInfo:nil];
}

- (id)fromArray:(NSArray *)array {
  return [array lu_mappedArrayWithBlock:^(id subJSON) {
    return [self fromJSONObject:subJSON];
  }];
}

- (id)fromDictionary:(NSDictionary *)dictionary {
  NSDictionary *attributes = dictionary;

  if ([self hasSingleDictionaryUnderRootKey:attributes]) {
    attributes = attributes[[self rootKey]];
  }

  return [self createFromAttributes:attributes];
}

- (id)fromJSONObject:(id)JSON {
  if ([JSON isKindOfClass:[NSArray class]]) {
    return [self fromArray:JSON];
  } else if ([JSON isKindOfClass:[NSDictionary class]]) {
    return [self fromDictionary:JSON];
  } else {
    return nil;
  }
}

- (NSString *)rootKey {
  return nil;
}

#pragma mark - Private Methods

- (BOOL)hasSingleDictionaryUnderRootKey:(NSDictionary *)dict {
  id objectUnderRootKey = dict[[self rootKey]];

  return [dict count] == 1 && objectUnderRootKey && [objectUnderRootKey isKindOfClass:[NSDictionary class]];
}

@end
