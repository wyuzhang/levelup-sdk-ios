#import <Foundation/Foundation.h>

@interface LUDictionarySerializer : NSObject

+ (NSDictionary *)parametersForModel:(id)model withAttributesNamed:(NSArray *)attributeNames;
+ (NSDictionary *)parametersForModel:(id)model withNonBlankAttributesNamed:(NSArray *)attributeNames;

@end
