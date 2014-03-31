// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface NSData (LUAdditions)

+ (NSData *)lu_dataWithBase64EncodedString:(NSString *)string;
+ (int8_t)lu_randomByte;
+ (NSData *)lu_randomDataOfLength:(NSUInteger)length;
- (NSString *)lu_base64Encoding;
- (NSString *)lu_hexString;
- (NSData *)lu_XORDataWithSecret:(NSData *)secret;

@end
