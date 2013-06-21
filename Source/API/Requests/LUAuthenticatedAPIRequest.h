#import "LUAPIRequest.h"

/**
 `LUAuthenticatedAPIRequest` is a subclass of `LUAPIRequest` which will include an authentication token if one is
 available.
 */
@interface LUAuthenticatedAPIRequest : LUAPIRequest

@end
