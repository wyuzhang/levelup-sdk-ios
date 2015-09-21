#import <Foundation/Foundation.h>

@interface BTSecKeyWrapper : NSObject

- (SecKeyRef) addPeerPublicKey:(NSString *)peerName keyBits:(NSData *)publicKey;
- (void) removePeerPublicKey:(NSString *)peerName;

@end
