@interface LUAPIModelBuilder : NSObject

+ (id)builder;
- (id)buildModelFromJSON:(id)JSON;
- (id)buildModelFromAttributes:(NSDictionary *)attributes;

@end
