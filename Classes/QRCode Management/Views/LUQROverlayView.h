#import <UIKit/UIKit.h>

@interface LUQROverlayView : UIView

@property (nonatomic, weak) UIImage *image;
@property (nonatomic, strong) NSArray *points;
@property (nonatomic, readonly) CGRect cropRect;

@end
