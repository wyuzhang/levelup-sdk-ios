// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@interface LUAbstractJSONModelFactory : NSObject

+ (instancetype)factory;
- (id)createFromAttributes:(NSDictionary *)attributes;
- (id)fromArray:(NSArray *)array;
- (id)fromDictionary:(NSDictionary *)dictionary;
- (id)fromJSONObject:(id)JSON;
- (NSString *)rootKey;

@end
