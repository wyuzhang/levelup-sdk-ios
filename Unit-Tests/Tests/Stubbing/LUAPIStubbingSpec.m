/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

SPEC_BEGIN(LUAPIStubbingSpec)

describe(@"LUAPIStubbing", ^{
  __block LUAPIStubbing *apiStubbing;
  LUAPIStub *stub1 = [LUAPIStub stubForWebURL:[NSURL URLWithString:@"https://www.stub1.com"] withBody:@"<p>Stub1</p>"];
  LUAPIStub *stub2 = [LUAPIStub stubForWebURL:[NSURL URLWithString:@"https://www.stub2.com"] withBody:@"<p>Stub2</p>"];
  LUAPIStub *stubDuplicate = [LUAPIStub stubForWebURL:[NSURL URLWithString:@"https://www.stub2.com"]
                                                     withBody:@"<p>Stub3</p>"];

  beforeEach(^{
    apiStubbing = [LUAPIStubbing sharedInstance];
  });

  describe(@"sharedInstance", ^{
    it(@"returns an LUAPIStubbing instance", ^{
      [[apiStubbing should] beKindOfClass:[LUAPIStubbing class]];
    });

    it(@"returns the same LUAPIStubbing instance each time", ^{
      id stubbing2 = [LUAPIStubbing sharedInstance];

      [[apiStubbing should] beIdenticalTo:stubbing2];
    });
  });

  describe(@"init", ^{
    it(@"defaults to an empty stubs list", ^{
      [[apiStubbing.stubs should] beEmpty];
    });
  });

  describe(@"clearStubs", ^{
    it(@"clears any added stubs", ^{
      [apiStubbing addStub:stub1];

      [apiStubbing clearStubs];

      [[apiStubbing.stubs should] beEmpty];
    });
  });

  describe(@"addStub:", ^{
    it(@"adds the stub", ^{
      [apiStubbing addStub:stub1];

      [[apiStubbing.stubs should] equal:@[stub1]];
    });

    context(@"when the next stub to add is not a duplicate", ^{
      it(@"adds the stub", ^{
        [apiStubbing addStub:stub2];

        [[apiStubbing.stubs should] equal:@[stub1, stub2]];
      });
    });

    context(@"when the next stub to add is a duplicate", ^{
      it(@"replaces the existing stub", ^{
        [apiStubbing addStub:stubDuplicate];

        [[apiStubbing.stubs should] equal:@[stub1, stubDuplicate]];
      });
    });
  });
});

SPEC_END
