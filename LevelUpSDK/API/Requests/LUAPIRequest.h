@interface LUAPIRequest : NSObject

@property (nonatomic, assign) BOOL includeAccessToken;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSDictionary *parameters;

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters;
+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters
                    includeAccessToken:(BOOL)includeAccessToken;
- (NSURLRequest *)urlRequest;

@end
