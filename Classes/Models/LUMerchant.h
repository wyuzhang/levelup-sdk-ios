#import <Foundation/Foundation.h>

@class CLLocation;
@class LUCohort;
@class LULocation;
@class LULoyalty;
@class LUMonetaryValue;

@interface LUMerchant : NSObject

@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *descriptionHtml;
@property (nonatomic, strong) LUMonetaryValue *earn;
@property (nonatomic, copy) NSString *facebookUrl;
@property (nonatomic, copy) NSNumber *featured;
@property (nonatomic, copy) NSString *categoryImageUrl_32x32_1x;
@property (nonatomic, copy) NSString *categoryImageUrl_32x32_2x;
@property (nonatomic, strong) LUCohort *emailCaptureCohort;
@property (nonatomic, copy) NSString *imageUrl_280x128_1x;
@property (nonatomic, copy) NSString *imageUrl_280x128_2x;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, strong) LULoyalty *loyalty;
@property (nonatomic, copy) NSNumber *loyaltyEnabled;
@property (nonatomic, copy) NSString *messageForTwitter;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *newsletterUrl;
@property (nonatomic, strong) LUMonetaryValue *onboarding;
@property (nonatomic, copy) NSString *opentableUrl;
@property (nonatomic, copy) NSString *publicUrl;
@property (nonatomic, copy) NSString *scvngrUrl;
@property (nonatomic, copy) NSString *searchNormalizedName;
@property (nonatomic, strong) LUMonetaryValue *spend;
@property (nonatomic, copy) NSString *twitterUsername;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *yelpUrl;

- (NSString *)categoryImageUrl;
- (LUMonetaryValue *)currentCredit;
- (LUMonetaryValue *)loyaltyAmountAvailable;
- (NSString *)imageUrl;
- (BOOL)isFeatured;
- (BOOL)isLoyaltyEnabled;
- (LULocation *)locationNearestTo:(CLLocation *)location;
- (NSString *)twitterUrl;

@end
