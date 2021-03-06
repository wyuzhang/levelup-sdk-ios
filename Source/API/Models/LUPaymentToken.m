/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUPaymentToken.h"

@implementation LUPaymentToken

#pragma mark - Creation

- (id)initWithAction:(NSString *)action data:(NSString *)data message:(NSString *)message
      paymentTokenID:(NSNumber *)paymentTokenID {
  self = [super init];
  if (!self) return nil;

  _action = action;
  _data = data;
  _message = message;
  _paymentTokenID = paymentTokenID;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUPaymentToken [address=%p, action=%@, data=%@, message=%@, paymentTokenID=%@]",
          self, self.action, self.data, self.message, self.paymentTokenID];
}

@end
