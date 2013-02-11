@class LUAPIRequest;

@interface LUTicketRequestBuilder : NSObject

+ (LUAPIRequest *)requestToCreateTicketWithBody:(NSString *)body;

@end
