#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

typedef void (^LUQRCodeDecoderCompletionHandler)(NSString *result);

@interface LUQRCodeDecoder : NSObject

- (void)decodeQRCodeFromSampleBuffer:(CMSampleBufferRef)sampleBuffer withCompletionHandler:(LUQRCodeDecoderCompletionHandler)completionHandler;

@end
