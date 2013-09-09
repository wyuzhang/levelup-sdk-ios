// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

@interface LUAPIModelSubclass1 : LUAPIModel
@property (nonatomic, copy) NSNumber *modelID;
@end

@implementation LUAPIModelSubclass1
@end

@interface LUAPIModelSubclass2 : LUAPIModel
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
      LUAPIModelSubclass2 *aModel = [[LUAPIModelSubclass2 alloc] init];
      aModel.modelID = @1;
      aModel.name = @"First";

      context(@"compared to another instance with the same modelId, but differing on another property", ^{
        LUAPIModelSubclass2 *anotherModel = [[LUAPIModelSubclass2 alloc] init];
        anotherModel.modelID = aModel.modelID;
        anotherModel.name = @"Second";

        it(@"should not be equal", ^{
          [[aModel shouldNot] equal:anotherModel];
          [[anotherModel shouldNot] equal:aModel];
        });

        it(@"should not have the same hash value", ^{
          [[theValue([aModel hash]) shouldNot] equal:theValue([anotherModel hash])];
        });
      });
    });
  });
});

SPEC_END
