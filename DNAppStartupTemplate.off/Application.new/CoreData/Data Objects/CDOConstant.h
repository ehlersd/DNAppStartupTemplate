//
//  CDOConstant.h
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import "DNManagedObject.h"

@interface CDOConstant : DNManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * value;

+ (instancetype)constant;
+ (instancetype)constantFromKey:(NSString*)keyValue;
+ (instancetype)constantFromKeyIfExists:(NSString*)keyValue;
- (instancetype)initWithKey:(NSString*)keyValue;
- (instancetype)initWithKeyIfExists:(NSString*)keyValue;

- (void)loadWithDictionary:(NSDictionary*)dict;
- (void)clearData;

@end
