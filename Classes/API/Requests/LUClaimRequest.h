#import <Foundation/Foundation.h>

@class LUCohort;
@class LUAPIRequest;

@interface LUClaimRequest : NSObject

+ (LUAPIRequest *)claimCohort:(LUCohort *)cohort;

@end
