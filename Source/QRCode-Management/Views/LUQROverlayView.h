#import <UIKit/UIKit.h>

@interface LUQROverlayView : UIView

@property (nonatomic, readonly) CGRect cropRect;
@property (nonatomic, strong) UIColor *crossHairsColor;
@property (nonatomic, weak) UIImage *image;
@property (nonatomic, strong) NSArray *points;

@end
