//
//  CDOConstant.m
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import "CDOConstant.h"
#import "CDConstantModel.h"

@implementation CDOConstant

@dynamic key;
@dynamic value;

#pragma mark - Entity description functions

+ (Class)entityModelClass
{
    return [CDConstantModel class];
}

+ (id)entityIDWithDictionary:(NSDictionary*)dict
{
    return [[self class] dictionaryNumber:dict withItem:@"key" andDefault:nil];
}

- (void)setId:(id)idValue
{
    [self setValue:idValue forKey:@"key"];
}

+ (instancetype)constant
{
    return [[self class] entity];
}

+ (instancetype)constantFromKey:(NSString*)keyValue
{
    return [[[self class] alloc] initWithKey:keyValue];
}

+ (instancetype)constantFromKeyIfExists:(NSString*)keyValue
{
    return [[[self class] alloc] initWithKeyIfExists:keyValue];
}

- (instancetype)initWithKey:(NSString*)keyValue
{
    return [self initWithID:keyValue];
}

- (instancetype)initWithKeyIfExists:(NSString*)keyValue
{
    return [self initWithIDIfExists:keyValue];
}

- (void)loadWithDictionary:(NSDictionary*)dict
{
    [super loadWithDictionary:dict];
    
    NSDictionary*   attributes  = [[self class] attributesForRepresentation:dict ofEntity:nil fromResponse:nil];
    
    self.key    = attributes[@"key"];
    self.value  = attributes[@"value"];
}

#pragma - mark Entity Fetch Details

+ (NSDictionary*)attributesForRepresentation:(NSDictionary*)representation
                                    ofEntity:(NSEntityDescription*)entity
                                fromResponse:(NSHTTPURLResponse*)response
{
    NSMutableDictionary*    mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];

    [mutablePropertyValues addEntriesFromDictionary:@{@"key":     [self dictionaryString:representation dirty:nil withItem:@"key"     andDefault:@""],
                                                      @"value":   [self dictionaryString:representation dirty:nil withItem:@"value"   andDefault:@""]   }];
    
    return mutablePropertyValues;
}

+ (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID*)objectID
                                 inManagedObjectContext:(NSManagedObjectContext*)context
{
    if ([super shouldFetchRemoteAttributeValuesForObjectWithID:objectID inManagedObjectContext:context] == YES)
    {
        return YES;
    }
    
    return YES;  // No detail content endpoint calls needed
}

+ (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription*)relationship
                               forObjectWithID:(NSManagedObjectID*)objectID
                        inManagedObjectContext:(NSManagedObjectContext*)context
{
    if ([super shouldFetchRemoteValuesForRelationship:relationship forObjectWithID:objectID inManagedObjectContext:context] == YES)
    {
        return YES;
    }
    
    return NO;  // No detail content endpoint calls needed
}

- (void)clearData
{
    [super clearData];

    self.key    = nil;
    self.value  = nil;
}

@end
