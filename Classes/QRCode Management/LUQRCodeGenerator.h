#import <UIKit/UIKit.h>

@interface LUQRCodeGenerator : NSObject

+ (UIImage *)QRCodeFromString:(NSString *)QRString;
+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage;
+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID;

@end
