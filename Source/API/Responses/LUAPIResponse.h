@interface LUAPIResponse : NSObject

@property (nonatomic, strong, readonly) NSHTTPURLResponse *HTTPURLResponse;

- (id)initWithHTTPURLResponse:(NSHTTPURLResponse *)HTTPURLResponse;
- (NSURL *)nextPageURL;

@end
