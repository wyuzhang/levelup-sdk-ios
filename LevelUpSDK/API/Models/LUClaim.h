#import "LUAPIModel.h"

@class LUCampaign;
@class LUCohort;

@interface LUClaim : LUAPIModel

@property (nonatomic, strong) LUCampaign *campaign;
@property (nonatomic, strong) LUCohort *cohort;
@property (nonatomic, strong) LUCohort *shareCohort;

@end
