// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIError.h"

@interface LUAPIError ()

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *object;
@property (nonatomic, copy) NSString *property;

@end

@implementation LUAPIError

#pragma mark - Creation

- (id)initWithMessage:(NSString *)message object:(NSString *)object property:(NSString *)property {
  self = [super init];
  if (!self) return nil;

  _message = message;
  _object = object;
  _property = property;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUAPIError [address=%p, message=%@, object=%@, property=%@]", self, self.message, self.object,
          self.property];
}

@end
