// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIError.h"

@implementation LUAPIError

#pragma mark - Creation

- (id)initWithCode:(NSString *)code message:(NSString *)message object:(NSString *)object property:(NSString *)property {
  self = [super init];
  if (!self) return nil;

  _code = code;
  _message = message;
  _object = object;
  _property = property;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUAPIError [address=%p, code=%@, message=%@, object=%@, property=%@]",
          self, self.code, self.message, self.object, self.property];
}

@end
