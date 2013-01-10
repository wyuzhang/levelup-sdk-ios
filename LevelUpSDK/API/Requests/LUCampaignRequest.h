#import <Foundation/Foundation.h>

@class LUAPIRequest;

@interface LUCampaignRequest : NSObject

+ (LUAPIRequest *)getCampaignWithId:(NSNumber *)campaignId;

@end
