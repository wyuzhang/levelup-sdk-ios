// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <AVFoundation/AVFoundation.h>

typedef void (^LUQRCodeDecoderCompletionHandler)(NSString *result);

@interface LUQRCodeDecoder : NSObject

- (void)decodeQRCodeFromSampleBuffer:(CMSampleBufferRef)sampleBuffer withCompletionHandler:(LUQRCodeDecoderCompletionHandler)completionHandler;

@end
