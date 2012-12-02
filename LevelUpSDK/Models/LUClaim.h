#import <Foundation/Foundation.h>

@class LUCampaign;
@class LUCohort;

@interface LUClaim : NSObject

@property (nonatomic, strong) LUCampaign *campaign;
@property (nonatomic, strong) LUCohort *cohort;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, strong) LUCohort *shareCohort;

@end
