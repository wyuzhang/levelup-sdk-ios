// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

/**
 `LUTicketRequestFactory` is used to build requests related to customer support tickets.
 */
@class LUAPIRequest;

@interface LUTicketRequestFactory : NSObject

/**
 Builds a request to create a support ticket.

 @param body The body of the ticket.
 */
+ (LUAPIRequest *)requestToCreateTicketWithBody:(NSString *)body;

@end
