/**
 Used to send custom user emails.
 */
@class LUAPIRequest;

@interface LUEmailsRequestFactory : NSObject

+ (LUAPIRequest *)requestToSendEmailWithID:(NSNumber *)emailID;

@end
