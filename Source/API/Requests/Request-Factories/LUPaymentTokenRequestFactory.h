// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

/**
 `LUPaymentTokenRequestFactory` is used to build the request to retrieve a user's payment token.
 */
@class LUAPIRequest;

@interface LUPaymentTokenRequestFactory : NSObject

/**
 Builds a request to retrieve the current user's payment token.

 The user may not be payment eligible. This could happen if they haven't added any credit cards, or if their credit card
 has expired. When that happens, this request will fail with the error code `LUAPIErrorNotFound`.
 */
+ (LUAPIRequest *)requestForPaymentToken;

@end
