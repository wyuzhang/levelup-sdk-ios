@class LUAbstractJSONModelFactory;

extern NSString * const LUAPIVersion13;
extern NSString * const LUAPIVersion14;

/**
 `LUAPIRequest` represents a request to the LevelUp API. To perform a request, an `LUAPIRequest` instance is passed
 to the `performRequest:success:failure` method of `LUAPIClient`. `LUAPIRequest` instances should usually be created
 by request builders.
 */
@interface LUAPIRequest : NSObject

/**
 The version of the LevelUp API to use for this request.
 */
@property (nonatomic, copy) NSString *apiVersion;

/**
 The HTTP method of the request: "GET", "POST", "PUT", or "DELETE".
 */
@property (nonatomic, copy) NSString *method;

/**
 An `LUAbstractJSONModelFactory` to parse the JSON response.
 */
@property (nonatomic, strong) LUAbstractJSONModelFactory *modelFactory;

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
 @param apiVersion The version of the API to use.
 @param parameters A dictionary of parameters to include with this request, or nil if the request has no parameters.
 @param modelFactory An instance of `LUAbstractJSONModelFactory` which will parse the response.
 */
+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            apiVersion:(NSString *)apiVersion
                            parameters:(NSDictionary *)parameters
                          modelFactory:(LUAbstractJSONModelFactory *)modelFactory;

- (id)initWithMethod:(NSString *)method
                path:(NSString *)path
          apiVersion:(NSString *)apiVersion
          parameters:(NSDictionary *)parameters
        modelFactory:(LUAbstractJSONModelFactory *)modelFactory;

/**
 Returns an `NSURL` instance for this API request.
 */
- (NSURL *)URL;

/**
 Returns an `NSMutableURLRequest` instance for this API request.
 */
- (NSMutableURLRequest *)URLRequest;

@end
