#import <CoreLocation/CoreLocation.h>
#import "LUAPIModel.h"

@class LUCohort;
@class LULocation;
@class LULoyalty;
@class LUMonetaryValue;

extern NSString * const MerchantWebService;
extern NSString * const MerchantYelpService;
extern NSString * const MerchantFacebookService;
extern NSString * const MerchantTwitterService;
extern NSString * const MerchantScvngrService;
extern NSString * const MerchantOpenTableService;
extern NSString * const MerchantNewsletterService;

@interface LUMerchant : LUAPIModel

@property (nonatomic, copy) NSString *descriptionHtml;
@property (nonatomic, strong) LUMonetaryValue *earn;
@property (nonatomic, strong) LUCohort *emailCaptureCohort;
@property (nonatomic, copy) NSString *facebookUrl;
@property (nonatomic, assign) BOOL featured;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, strong) LULoyalty *loyalty;
@property (nonatomic, assign) BOOL loyaltyEnabled;
@property (nonatomic, copy) NSString *messageForTwitter;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *newsletterUrl;
@property (nonatomic, strong) LUMonetaryValue *onboarding;
@property (nonatomic, copy) NSString *opentableUrl;
@property (nonatomic, copy) NSString *publicUrl;
@property (nonatomic, copy) NSString *scvngrUrl;
@property (nonatomic, strong) LUMonetaryValue *spend;
@property (nonatomic, copy) NSString *twitterUsername;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *yelpUrl;

- (NSString *)categoryImageUrl;
- (LUMonetaryValue *)currentCredit;
- (NSString *)imageUrl;
- (LULocation *)locationNearestTo:(CLLocation *)location;
- (NSString *)twitterUrl;
- (NSArray *)webLocations;

@end
