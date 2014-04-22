// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

/**
 `LUInterstitialRequestFactory` builds requests to retrieve interstitials.
 */
@interface LUInterstitialRequestFactory : NSObject

/**
 Builds a request for an interstitial for an order with the given UUID.

 If this order does not have an interestitial, this request will fail with the error code
 `LUAPIErrorNotFound`.

 @param UUID The UUID of an order.
 */
+ (LUAPIRequest *)requestForInterstitialForOrderWithUUID:(NSString *)UUID;

/**
 Builds a request to submit feedback from a feedback interstitial.

 If this order does not have an interestitial, this request will fail with the error code
 `LUAPIErrorNotFound`.

 @param UUID The UUID of an order.
 @param questionText The text of the question given to the user.
 @param rating The user's rating of the order.
 @param comment The user's comment on the order.
 */
+ (LUAPIRequest *)requestToSubmitFeedbackForOrderWithUUID:(NSString *)UUID
                                             questionText:(NSString *)questionText
                                                   rating:(int)rating
                                                  comment:(NSString *)comment;

@end
