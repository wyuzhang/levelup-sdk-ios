#import "LUCampaign.h"
#import "LUCohort.h"
#import "LUJSONDeserializer.h"

@implementation LUCohort

#pragma mark -
#pragma mark Public Methods

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifiers:@[@"cohort", @"email_capture_cohort", @"share_cohort"]];
  }
}

@end
