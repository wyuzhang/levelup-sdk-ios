/**
 `LUCauseAffiliationRequestFactory` is used to build requests related to cause affiliations.
 */
@class LUAPIRequest;
@class LUCauseAffiliation;

@interface LUCauseAffiliationRequestFactory : NSObject

/**
 Builds a request to return the cause affiliation for the current user.

 On success, this request will return an `LUCauseAffiliation` instance.
 */
+ (LUAPIRequest *)requestForCauseAffiliation;

/**
 Builds a request to set the current user's cause.

 On success, this request will return `nil`.

 @param causeAffiliation The `LUCauseAffiliation` to create.
 */
+ (LUAPIRequest *)requestToCreateCauseAffiliation:(LUCauseAffiliation *)causeAffiliation;

/**
 Builds a request to remove the current user's cause affiliation.

 On success, this request will return `nil`.
 */
+ (LUAPIRequest *)requestToRemoveCauseAffiliation;

@end
