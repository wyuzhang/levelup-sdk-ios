/*
 * Copyright (C) 2016 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUMonetaryValue.h"
#import "LUOrderAheadMenuItemOption.h"
#import "LUOrderAheadMenuItemOptionGroup.h"
#import "NSArray+LUAdditions.h"
#import "NSNumber+LUAdditions.h"

@implementation LUOrderAheadMenuItemOptionGroup {
  NSNumber *_selectionType;
}

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithDefaultOptionIDs:(NSArray *)defaultOptionIDs
                            displayOrder:(NSUInteger)displayOrder
                        freeChoicesCount:(NSNumber *)freeChoicesCount
                     maximumChoicesCount:(NSNumber *)maximumChoicesCount
                     minimumChoicesCount:(NSNumber *)minimumChoicesCount
                                    name:(NSString *)name
                           optionGroupID:(NSNumber *)optionGroupID
                                 options:(NSArray *)options {
  self = [super init];
  if (!self) return nil;

  _defaultOptionIDs = defaultOptionIDs;
  _displayOrder = displayOrder;
  _freeChoicesCount = freeChoicesCount;
  _maximumChoicesCount = maximumChoicesCount;
  _minimumChoicesCount = minimumChoicesCount;
  _name = name;
  _optionGroupID = optionGroupID;
  _options = options;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadMenuItemOptionGroup [address=%p, defaultOptionIDs=%@, "
          "displayOrder=%lu, freeChoicesCount=%@, maximumChoicesCount=%@, minimumChoicesCount=%@, name=%@, "
          "optionGroupID=%@, options=%@, selectionType=%ld]", self, self.defaultOptionIDs,
          (unsigned long)self.displayOrder, self.freeChoicesCount, self.maximumChoicesCount,
          self.minimumChoicesCount, self.name, self.optionGroupID, self.options, (long)self.selectionType];
}

#pragma mark - Public Methods

- (BOOL)hasAllOptionsFree {
  for (LUOrderAheadMenuItemOption *option in self.options) {
    if ([option.price.amount lu_isPositiveNumber]) {
      return NO;
    }
  }

  return YES;
}

- (BOOL)isValidForSelectedOptionCount:(NSNumber *)selectedOptionCount {
  return [selectedOptionCount lu_isGreaterThanOrEqualTo:self.minimumChoicesCount] &&
         [selectedOptionCount lu_isLessThanOrEqualTo:self.maximumChoicesCount];
}

- (NSArray *)optionsWithIDs:(NSArray *)optionIDs {
  return [self.options lu_filteredArrayWithBlock:^BOOL(LUOrderAheadMenuItemOption *option) {
    return [optionIDs containsObject:option.optionID];
  }];
}

- (LUMonetaryValue *)priceOfDefaultOptions {
  return [self costOfOptionsWithIDs:[self nonFreeOptionIDsFromOptionIDs:self.defaultOptionIDs]];
}

- (LUMonetaryValue *)priceOfOptionsWithIDs:(NSArray *)optionIDs {
  return [self costOfOptionsWithIDs:[self nonFreeOptionIDsFromOptionIDs:optionIDs]];
}

- (LUUIOrderAheadMenuItemOptionGroupSelectionType)selectionType {
  if (!_selectionType) {
    _selectionType = @([self selectionTypeForMinimumChoicesCount:self.minimumChoicesCount
                                             maximumChoicesCount:self.maximumChoicesCount]);
  }

  return [_selectionType integerValue];
}

#pragma mark - Private Methods

- (LUMonetaryValue *)costOfOptionsWithIDs:(NSArray *)optionIDs {
  NSArray *options = [self optionsWithIDs:optionIDs];
  return [LUMonetaryValue monetaryValueByAddingValues:
          [options lu_mappedArrayWithBlock:^id(LUOrderAheadMenuItemOption *option) {
    return option.price;
  }]];
}

- (NSArray *)nonFreeOptionIDsFromOptionIDs:(NSArray *)optionIDs {
  NSArray *descendingPriceSortedOptionIDs = [optionIDs sortedArrayUsingComparator:
                                             ^NSComparisonResult(NSNumber *optionID, NSNumber *anotherOptionID) {
                                               return -[[self costOfOptionsWithIDs:@[optionID]].amount compare:
                                                        [self costOfOptionsWithIDs:@[anotherOptionID]].amount];
                                             }];

  return [descendingPriceSortedOptionIDs lu_subarrayWithStartIndex:self.freeChoicesCount.integerValue];
}

- (LUUIOrderAheadMenuItemOptionGroupSelectionType)selectionTypeForMinimumChoicesCount:(NSNumber *)minimumChoicesCount
                                                                  maximumChoicesCount:(NSNumber *)maximumChoicesCount {
  if ([maximumChoicesCount lu_isPositiveNumber] && ![minimumChoicesCount lu_isGreaterThan:@0]) {
    return LUUIOrderAheadMenuItemOptionGroupSelectionTypeUpTo;
  }

  if ([minimumChoicesCount lu_isPositiveNumber] && ![maximumChoicesCount lu_isGreaterThanOrEqualTo:minimumChoicesCount]) {
    return LUUIOrderAheadMenuItemOptionGroupSelectionTypeAtLeast;
  }

  if ([minimumChoicesCount lu_isPositiveNumber] && [maximumChoicesCount lu_isPositiveNumber]
      && ![minimumChoicesCount isEqual:maximumChoicesCount]) {
    return LUUIOrderAheadMenuItemOptionGroupSelectionTypeBetween;
  }

  if ([minimumChoicesCount isEqualToNumber:@1] && [maximumChoicesCount isEqual:minimumChoicesCount]) {
    return LUUIOrderAheadMenuItemOptionGroupSelectionTypeExactlyOne;
  }

  if ([minimumChoicesCount lu_isGreaterThan:@1] && [maximumChoicesCount isEqual:minimumChoicesCount]) {
    return LUUIOrderAheadMenuItemOptionGroupSelectionTypeExactlyOverOne;
  }

  return LUUIOrderAheadMenuItemOptionGroupSelectionTypeAny;
}

@end
