// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface LUOneTimePad : NSObject

@property (nonatomic, copy, readonly) NSData *data;

+ (instancetype)loadOneTimePad;
+ (instancetype)oneTimePadWithBase64EncodedString:(NSString *)string;
+ (instancetype)saveNewOneTimePad;

- (NSString *)decodeString:(NSString *)string;
- (NSString *)encodeString:(NSString *)string;

- (NSString *)base64Encoding;
- (NSUInteger)length;

@end
