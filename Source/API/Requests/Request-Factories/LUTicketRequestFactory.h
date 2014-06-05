// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

/**
 `LUTicketRequestFactory` is used to build requests related to customer support tickets.
 */
@interface LUTicketRequestFactory : NSObject

/**
 Builds a request to create a support ticket.

 @warning Use of this request requires an Enterprise SDK license.
 @param body The body of the ticket.
 */
+ (LUAPIRequest *)requestToCreateTicketWithBody:(NSString *)body;

@end
