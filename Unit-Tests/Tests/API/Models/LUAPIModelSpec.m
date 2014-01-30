// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

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
});

SPEC_END
