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

#import "NSArray+LUAdditions.h"

@implementation NSArray (LUAdditions)

- (id)lu_firstObject {
  if (self.count <= 0) {
    return nil;
  }

  return [self firstObject];
}

- (NSArray *)lu_filteredArrayWithBlock:(BOOL (^)(id obj))block {
  return [self filteredArrayUsingPredicate:
           [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull obj, NSDictionary<NSString *, id> * _Nullable bindings) {
              return block(obj);
           }]];
}

- (NSArray *)lu_mappedArrayWithBlock:(id (^)(id obj))block {
  NSMutableArray *new = [NSMutableArray array];

  for (id obj in self) {
    id newObj = block(obj);
    if (newObj) {
      [new addObject:newObj];
    }
  }

  return new;
}

@end
