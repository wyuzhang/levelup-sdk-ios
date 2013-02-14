/**
 `LUDivisionRequestBuilder` is used to build requests related to divisions.
 */
@class LUAPIRequest;

@interface LUDivisionRequestBuilder : NSObject

/**
 Builds a request to retrieve all divisions.

 On success, this request will return an array of `LUDivision` instances.
 */
+ (LUAPIRequest *)requestForAllDivisions;

@end
