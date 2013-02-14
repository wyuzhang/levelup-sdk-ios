#import "LUAPIModel.h"

/**
 `LUQRCode` is the payment token that represents a user. This code is scanned at merchants to identify the user.
 */
@interface LUQRCode : LUAPIModel

/**
 The QR code data.
 */
@property (nonatomic, copy) NSString *data;

/**
 A URL for an image containing the QR code.
 */
@property (nonatomic, copy) NSString *dataImageUrl;

@end
