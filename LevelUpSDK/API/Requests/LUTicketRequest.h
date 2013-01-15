@class LUAPIRequest;
@class LUTicket;

@interface LUTicketRequest : NSObject

+ (LUAPIRequest *)createTicket:(LUTicket *)ticket;

@end
