#import <Foundation/Foundation.h>

@interface LUTicket : NSObject

@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSNumber *modelId;

- (NSDictionary *)parameters;

@end
