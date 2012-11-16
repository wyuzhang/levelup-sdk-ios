#import <Foundation/Foundation.h>

@interface LUJSONDeserializer : NSObject

+ (id)deserializeJSON:(id)JSON;
+ (void)registerModel:(Class)model withIdentifier:(NSString *)identifier;
+ (void)registerModel:(Class)model withIdentifiers:(NSArray *)identifiers;

@end
