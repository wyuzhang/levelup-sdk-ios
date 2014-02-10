// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

/**
 This action is used for interstitials that request the user to provide feedback.
 */
@interface LUInterstitialFeedbackAction : LUAPIModel

/**
 A question displayed to the user to give feedback on their experience.
 */
@property (nonatomic, copy, readonly) NSString *questionText;

- (id)initWithQuestionText:(NSString *)questionText;

@end
