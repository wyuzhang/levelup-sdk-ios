@interface LUAPIErrorBuilder : NSObject

+ (NSError *)error:(NSError *)error withMessagesFromJSON:(id)JSON;

@end
