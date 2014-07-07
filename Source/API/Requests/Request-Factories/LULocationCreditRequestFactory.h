// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

/**
 `LULocationCreditRequestFactory` is used to request available credit at a location.
 */
@interface LULocationCreditRequestFactory : NSObject

/**
 Builds a request to retrieve available credit at a location. If the requesting user is
 authenticated, it will return the available credit for that user. If there is not an authenticated
 user, then the result will be the available credit
 for a brand new user.

 On success, this request will return an `LUMonetaryValue` containing the available credit amount.

 @warning If an access token is present, it must have the `manage_user_campaigns` permission.
 @param locationID The ID of the location.
 */
+ (LUAPIRequest *)requestForCreditAtLocationID:(NSNumber *)locationID;

@end
