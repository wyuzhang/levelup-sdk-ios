// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUInterstitialFeedbackAction.h"

@implementation LUInterstitialFeedbackAction

#pragma mark - Creation

- (id)initWithQuestionText:(NSString *)questionText {
  self = [super init];
  if (!self) return nil;

  _questionText = questionText;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUInterstitialFeedbackAction [address=%p, questionText=%@]",
          self, self.questionText];
}

@end
