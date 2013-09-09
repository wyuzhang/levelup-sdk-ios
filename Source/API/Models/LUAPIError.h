// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

/**
 If an API request returns an error, the response may include one or more `LUAPIError` objects. These will be included
 within the `userInfo` of the `NSError` returned by a network request.

 An error will have a `message`, and may have an `object` and `property`. These latter two properties are useful for
 validation errors. For example, if a user attempts to register without providing an email address, the object would be
 "user" and the property would be "email".
 */
@interface LUAPIError : LUAPIModel

/**
 A human-readable description of the error.
 */
@property (nonatomic, copy, readonly) NSString *message;

/**
 A description of the object to which the error refers, such as "user" or "location". This can be useful to distinguish
 validation errors within nested objects.
 */
@property (nonatomic, copy, readonly) NSString *object;

/**
 The property to which the error refers. This is typically used for validation errors. For example, if a user attempts
 to register without providing an email address, the object would be "user" and the property would be "email".
 */
@property (nonatomic, copy, readonly) NSString *property;

- (id)initWithMessage:(NSString *)message object:(NSString *)object property:(NSString *)property;

@end
