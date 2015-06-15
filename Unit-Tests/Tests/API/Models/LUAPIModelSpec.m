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

#import "LUAPIModel.h"

@interface LUAPIModelSubclass1 : LUAPIModel
@property (nonatomic, copy) NSNumber *modelID;
@end

@implementation LUAPIModelSubclass1
@end

@interface LUAPIModelSubclass2 : LUAPIModel
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, copy) NSNumber *modelID;
@property (nonatomic, copy) NSString *name;
@end

@implementation LUAPIModelSubclass2
@end

SPEC_BEGIN(LUAPIModelSpec)

describe(@"LUAPIModel", ^{
  describe(@"equality", ^{
    context(@"an instance of LUAPIModel", ^{
      LUAPIModel *aModel = [[LUAPIModel alloc] init];

      context(@"compared to nil", ^{
        it(@"should not be equal", ^{
          [[aModel shouldNot] equal:nil];
        });
      });

      context(@"compared to itself", ^{
        LUAPIModel *anotherModel = aModel;

        it(@"should be equal", ^{
          [[aModel should] equal:anotherModel];
          [[anotherModel should] equal:aModel];
        });

        it(@"should have the same hash value", ^{
          [[theValue([aModel hash]) should] equal:theValue([anotherModel hash])];
        });
      });
    });

    context(@"an instance of a subclass of LUAPIModel", ^{
      context(@"compared to a different subclass of LUAPIModel with identical properties", ^{
        LUAPIModelSubclass1 *subclass1 = [[LUAPIModelSubclass1 alloc] init];
        subclass1.modelID = @1;

        LUAPIModelSubclass2 *subclass2 = [[LUAPIModelSubclass2 alloc] init];
        subclass2.modelID = subclass1.modelID;

        it(@"should not be equal", ^{
          [[subclass1 shouldNot] equal:subclass2];
          [[subclass2 shouldNot] equal:subclass1];
        });
      });
    });

    context(@"compared to another instance of the same class", ^{
      __block LUAPIModelSubclass2 *aModel, *anotherModel;

      beforeEach(^{
        aModel = [[LUAPIModelSubclass2 alloc] init];
        aModel.modelID = @1;

        anotherModel = [[LUAPIModelSubclass2 alloc] init];
        anotherModel.modelID = aModel.modelID;
      });

      context(@"when all properties are equal", ^{
        it(@"should be equal", ^{
          [[aModel should] equal:anotherModel];
          [[anotherModel should] equal:aModel];
        });

        it(@"should have the same hash value", ^{
          [[theValue([aModel hash]) should] equal:theValue([anotherModel hash])];
        });
      });

      context(@"when a property differs", ^{
        beforeEach(^{
          aModel.name = @"First";
          anotherModel.name = @"Second";
        });

        it(@"should not be equal", ^{
          [[aModel shouldNot] equal:anotherModel];
          [[anotherModel shouldNot] equal:aModel];
        });
      });

      context(@"when a property is present in one instance but not the other", ^{
        beforeEach(^{
          aModel.name = @"First";
          anotherModel.name = nil;
        });

        it(@"should not be equal", ^{
          [[aModel shouldNot] equal:anotherModel];
          [[anotherModel shouldNot] equal:aModel];
        });
      });

      context(@"when comparing unequal properties with the same hash", ^{
        beforeEach(^{
          aModel.dictionary = @{@"1": @"a"};
          anotherModel.dictionary = @{@"2": @"b"};
        });

        it(@"should not be equal", ^{
          [[aModel shouldNot] equal:anotherModel];
          [[anotherModel shouldNot] equal:aModel];
        });
      });
    });
  });

  describe(@"secure coding", ^{
    it(@"conforms to NSSecureCoding", ^{
      [[[LUAPIModel class] should] conformToProtocol:@protocol(NSSecureCoding)];
    });

    it(@"supports secure coding", ^{
      [[theValue([LUAPIModel supportsSecureCoding]) should] beYes];
    });

    describe(@"encodes and decodes", ^{
      LUAPIModelSubclass2 *model = [[LUAPIModelSubclass2 alloc] init];
      model.dictionary = @{@"a": @1};
      model.modelID = @1;
      model.name = @"model";

      NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
      [[data shouldNot] beNil];

      id decoded = [NSKeyedUnarchiver unarchiveObjectWithData:data];
      [[decoded should] equal:model];
    });
  });
});

SPEC_END
