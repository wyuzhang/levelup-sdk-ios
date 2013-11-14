// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUGenericQRCodeGenerator.h"
#import "LUPaymentQRCodeGenerator.h"
#import "NSNumber+Base36.h"

static NSString * const kTipTypePercent = @"0";
static NSString * const kCurrentQRCodeVersion = @"02";
static NSString * const kQRCodeSentinel = @"LU";

@interface LUPaymentQRCodeGenerator ()

@property (nonatomic, assign) NSInteger glowColorID;
@property (nonatomic, strong) NSString *paymentToken;
@property (nonatomic, assign) NSInteger tipPercentage;

@end

@implementation LUPaymentQRCodeGenerator

#pragma mark - Public Methods

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken {
  LUPaymentQRCodeGenerator *generator = [[self alloc] initWithPaymentToken:paymentToken tipPercentage:0 glowColorID:0];

  return [generator image];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage {
  LUPaymentQRCodeGenerator *generator = [[self alloc] initWithPaymentToken:paymentToken tipPercentage:tipPercentage glowColorID:0];

  return [generator image];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID {
  LUPaymentQRCodeGenerator *generator = [[self alloc] initWithPaymentToken:paymentToken tipPercentage:tipPercentage glowColorID:glowColorID];

  return [generator image];
}

#pragma mark - Private Methods

- (id)initWithPaymentToken:(NSString *)paymentToken tipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID {
  self = [super init];
  if (!self) return nil;

  _paymentToken = paymentToken;
  _glowColorID = glowColorID;
  _tipPercentage = tipPercentage;

  return self;
}

- (NSString *)formattedQRCodeString {
  NSArray *components = @[
    self.paymentToken,
    kCurrentQRCodeVersion,
    kTipTypePercent,
    [self tipPercentBase36],
    [self glowColorIDBase36],
    kQRCodeSentinel];

  return [components componentsJoinedByString:@""];
}

- (NSString *)glowColorIDBase36 {
  return [[[NSNumber numberWithInt:self.glowColorID] lu_base36Value] substringToIndex:1];
}

- (UIImage *)image {
  return [LUGenericQRCodeGenerator QRCodeFromString:[self formattedQRCodeString]];
}

- (NSString *)tipPercentBase36 {
  NSString *tipPercentBase36 = [[NSNumber numberWithInteger:self.tipPercentage] lu_base36Value];

  if (tipPercentBase36.length < 2) {
    return [NSString stringWithFormat:@"0%@", tipPercentBase36];
  } else if (tipPercentBase36.length > 2) {
    return [tipPercentBase36 substringToIndex:2];
  } else {
    return tipPercentBase36;
  }
}

@end
