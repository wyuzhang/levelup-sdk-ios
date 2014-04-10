// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIRequest.h"
#import "LUInterstitialJSONFactory.h"
#import "LUInterstitialRequestFactory.h"

@implementation LUInterstitialRequestFactory

+ (LUAPIRequest *)requestForInterstitialForOrderWithUUID:(NSString *)UUID {
  NSString *path = [NSString stringWithFormat:@"orders/%@/interstitial", UUID];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUInterstitialJSONFactory factory]];
}

+ (LUAPIRequest *)requestToSubmitFeedbackForOrderWithUUID:(NSString *)UUID
                                             questionText:(NSString *)questionText
                                                   rating:(int)rating
                                                  comment:(NSString *)comment {
  NSString *path = [NSString stringWithFormat:@"orders/%@/feedback", UUID];
  NSString *ratingString = [NSString stringWithFormat:@"%d", rating];

  NSDictionary *parameters = @{
    @"question_text": questionText,
    @"rating": ratingString,
    @"comment" : comment
  };

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"feedback": parameters}
                               modelFactory:[LUInterstitialJSONFactory factory]];
}

@end
