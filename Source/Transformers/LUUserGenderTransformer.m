#import "LUUser.h"
#import "LUUserGenderTransformer.h"

@interface LUUserGenderTransformer ()

@property (nonatomic, strong) NSMapTable *genderMap;
@property (nonatomic, strong) NSDictionary *reverseGenderMap;

@end

NSString * const LUUserGenderTransformerName = @"LUUserGenderTransformerName";

@implementation LUUserGenderTransformer

+ (Class)transformedValueClass {
  return [NSString class];
}

- (id)transformedValue:(id)value {
  return [[self.genderMap objectForKey:value] capitalizedString];
}

- (id)reverseTransformedValue:(id)value {
  return [self.reverseGenderMap objectForKey:[value lowercaseString]];
}

#pragma mark - Getters

- (NSMapTable *)genderMap {
  if (_genderMap) return _genderMap;
  _genderMap = [[NSMapTable alloc] init];
  [_genderMap setObject:@"male" forKey:@(LUGenderMale)];
  [_genderMap setObject:@"female" forKey:@(LUGenderFemale)];
  [_genderMap setObject:@"unspecified" forKey:@(LUGenderUnspecified)];
  return _genderMap;
}

- (NSDictionary *)reverseGenderMap {
  if (_reverseGenderMap) return _reverseGenderMap;
  NSArray *keys = [[self.genderMap dictionaryRepresentation] allValues];
  NSArray *values = [[self.genderMap dictionaryRepresentation] allKeys];
  _reverseGenderMap = [NSDictionary dictionaryWithObjects:values forKeys:keys];
  return _reverseGenderMap;
}

@end
