// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <OHHTTPStubs/OHHTTPStubs.h>

@interface LUAPIStub : NSObject

@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, copy) NSString *HTTPMethod;
@property (nonatomic, strong) id requestBodyJSON;
@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, copy) NSData *responseData;
@property (nonatomic, copy) NSDictionary *responseHeaders;
@property (nonatomic, copy) NSString *responseType;
@property (nonatomic, copy) NSURL *URL;

+ (LUAPIStub *)apiStubForVersion:(NSString *)apiVersion
                            path:(NSString *)path
                      HTTPMethod:(NSString *)HTTPMethod
                   authenticated:(BOOL)authenticated
                    responseData:(NSData *)responseData;
+ (LUAPIStub *)stubForWebURL:(NSURL *)URL withBody:(NSString *)body;

- (BOOL)matchesRequest:(NSURLRequest *)request;
- (OHHTTPStubsResponse *)response;
- (id)responseJSON;

@end
