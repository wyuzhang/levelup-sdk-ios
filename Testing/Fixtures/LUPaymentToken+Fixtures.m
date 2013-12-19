// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUPaymentToken+Fixtures.h"

@implementation LUPaymentToken (Fixtures)

+ (LUPaymentToken *)fixture {
  return [[LUPaymentToken alloc] initWithData:@"LU02000TESTTESTTEST01234" paymentTokenID:@1];
}

@end
