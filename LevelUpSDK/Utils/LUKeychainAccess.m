#import "LUKeychainAccess.h"

@implementation LUKeychainAccess

+ (BOOL)deleteStringForKey:(NSString *)key {
	if (key == nil) {
		return NO;
	}

  NSMutableDictionary *query = [self queryDictionaryForKey:key];
  OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);

  if (status == errSecSuccess) {
    return YES;
  }

  return NO;
}

+ (BOOL)saveString:(NSString *)inputString forKey:(NSString	*)key {
  BOOL success = NO;

  NSMutableDictionary *query = [self queryDictionaryForKey:key];

  NSData *data = [inputString dataUsingEncoding:NSUTF8StringEncoding];
  query[(__bridge id)kSecValueData] = data;

  OSStatus addStatus = SecItemAdd((__bridge CFDictionaryRef)query, NULL);

  if (addStatus == errSecSuccess) {
    success = YES;
  } else if (addStatus == errSecDuplicateItem) {
    NSMutableDictionary *updateQuery = [NSMutableDictionary dictionary];
    updateQuery[(__bridge id)kSecValueData] = data;

    OSStatus updateStatus = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)updateQuery);

    if (updateStatus == errSecSuccess) {
      success = YES;
    } else {
      success = NO;
    }
  } else {
    success = NO;
  }

  return success;
}

+ (NSString *)stringForKey:(NSString *)key {
  NSString *returnString;

	if (key != nil) {
    NSMutableDictionary *query = [self queryDictionaryForKey:key];

    query[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    query[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;

    CFTypeRef result;
    NSData *data;
    OSStatus error = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);

    if (error == noErr) {
      data = CFBridgingRelease(result);
    }

    if (data) {
      returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
  }

  return returnString;
}

#pragma mark - Private Methods

+ (NSMutableDictionary *)queryDictionaryForKey:(NSString *)key {
  NSMutableDictionary *query = [NSMutableDictionary dictionary];
  query[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;

  NSData *encodedIdentifier = [key dataUsingEncoding:NSUTF8StringEncoding];
  query[(__bridge id)kSecAttrAccount] = encodedIdentifier;

  return query;
}

@end
