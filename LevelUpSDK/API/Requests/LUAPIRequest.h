#import <Foundation/Foundation.h>

@interface LUAPIRequest : NSObject

@property (nonatomic, strong, readonly) NSURLRequest *urlRequest;

+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters;
+ (LUAPIRequest *)apiRequestWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters
                    skipAuthentication:(BOOL)skipAuthentication;

@end
