#import <UIKit/UIKit.h>

@interface LUQRCodeGenerator : NSObject

@property (nonatomic, copy) NSString *baseString;
@property (nonatomic, assign) NSInteger glowColorID;
@property (nonatomic, assign) NSInteger tipPercentage;

+ (UIImage *)QRCodeFromString:(NSString *)QRString;
+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage;
+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID;

@end
