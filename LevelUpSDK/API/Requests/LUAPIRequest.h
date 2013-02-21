#import "LUAPIModelBuilder.h"

/**
 `LUAPIRequest` represents a request to the LevelUp API. To perform a request, an `LUAPIRequest` instance is passed
 to the `performRequest:success:failure` method of `LUAPIClient`. `LUAPIRequest` instances should usually be created
 by request builders.
 */
@interface LUAPIRequest : NSObject

/**
 Specifies whether the request should include an authentication access token is one is available. This defaults to
 YES.
 */
@property (nonatomic, assign) BOOL includeAccessToken;

/**
 The HTTP method of the request: "GET", "POST", "PUT", or "DELETE".
 */
@property (nonatomic, copy) NSString *method;

/**
 An `LUAPIModelBuilder` to parse the JSON response.
 */
@property (nonatomic, strong) LUAPIModelBuilder *modelBuilder;

/**
 The path component of the URL of the request.
 */
@property (nonatomic, copy) NSString *path;

/**
 An `NSDictionary` of values to be passed as parameters.
 */
@property (nonatomic, copy) NSDictionary *parameters;

/**
 Returns an `LUAPIRequest` with the specified method, path and parameters. The `includeAccessToken` parameter will
 default to YES.

 @param method An HTTP method: "GET", "POST", "PUT", or "DELETE".
 @param path The path of the API request, e.g. "/users".
 @param parameters A dictionary of parameters to include with this request, or nil if the request has no parameters.
 */
+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters;

/**
 Returns an `LUAPIRequest` with the specified method, path, parameters and `includeAccessToken` setting.

 @param method An HTTP method: "GET", "POST", "PUT", or "DELETE".
 @param path The path of the API request, e.g. "/users".
 @param parameters A dictionary of parameters to include with this request, or nil if the request has no parameters.
 @param includeAccessToken Specifies whether this request should include an authentication token if one is available.
 */
+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters
                    includeAccessToken:(BOOL)includeAccessToken;

/**
 Returns an `NSURLRequest` instance for this API request.
 */
- (NSURLRequest *)urlRequest;

@end
