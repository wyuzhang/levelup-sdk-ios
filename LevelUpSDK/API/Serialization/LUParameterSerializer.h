@class LUAPIModel;

@interface LUParameterSerializer : NSObject

+ (NSDictionary *)nonBlankParametersForModel:(LUAPIModel *)model attributes:(NSArray *)attributes;
+ (NSDictionary *)parametersForModel:(LUAPIModel *)model attributes:(NSArray *)attributes;

@end
