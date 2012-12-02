#import <Foundation/Foundation.h>

@class LUAPIRequest;

@interface LUCategoryRequest : NSObject

+ (LUAPIRequest *)getCauseCategories;
+ (LUAPIRequest *)getCategories;

@end
