//
//  CDConstantModel.m
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "CDConstantModel.h"

#import "CDConstantsDataModel.h"
#import "CDOConstant.h"

@interface CDConstantModel ()

@end

@implementation CDConstantModel

+ (Class)dataModelClass
{
    return [CDConstantsDataModel class];
}

#pragma mark - Sort Keys

- (NSArray*)getFromIDSortKeys   {   return @[ @"key" ];     }
- (NSArray*)getAllSortKeys      {   return @[ @"key" ];     }

#pragma mark - getFromKey

- (DNModelWatchObject*)getFromKey:(NSString*)key didChange:(DNModelWatchObjectDidChangeHandlerBlock)handler
{
    return [self getFromID:key didChange:handler];
}

- (NSPredicate*)getFromID_FetchRequestPredicate:(id)idValue
{
    return [NSPredicate predicateWithFormat:@"key == %@", idValue];
}

@end
