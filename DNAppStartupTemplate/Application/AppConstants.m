//
//  AppConstants.m
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import "AppConstants.h"

#import "CDConstantModel.h"

@implementation AppConstants

+ (BOOL)resetConstants
{
    return [[DNAppConstants constantValue:@"ResetConstants"] boolValue];
}

+ (NSUInteger)appStoreID                {   return [[[self class] constantValue:@"appStoreID"] integerValue];       }
    
+ (NSString*)hockeyAppLiveID            {   return [[self class] constantValue:@"hockeyAppLiveID"];                 }
+ (NSString*)hockeyAppBetaID            {   return [[self class] constantValue:@"hockeyAppBetaID"];                 }
+ (NSString*)flurryApiKey               {   return [[self class] constantValue:@"flurryApiKey"];                    }
+ (NSString*)crashlyticsApiKey          {   return [[self class] constantValue:@"crashlyticsApiKey"];               }

+ (NSString*)appTheme                   {   return [[self class] constantValue:@"appTheme"];                        }

/*
+ (UIColor*)colorDefaultTabContentBG    {   return [[self class] colorConstant:@"colorDefaultTabContentBG"];          }

+ (BOOL)flagBioTitlingForceUpper        {   return [[self class] boolConstant:@"flagBioTitlingForceUpper"];           }

+ (UIFont*)fontSystemMenuAbout          {   return [[self class] fontConstant:@"fontSystemMenuAbout"];             }

+ (CGSize)sizePeoplePartnersThumbnails  {   return [[self class] sizeConstant:@"sizePeoplePartnersThumbnails"];    }

+ (double)noteNavBarCornerRadius        {   return [[self class] doubleConstant:@"noteNavBarCornerRadius"];        }
*/

+ (id)constantValue:(NSString*)key
{
    CDOConstant*    constant = [CDOConstant constantFromKeyIfExists:key];
    if (constant == nil)
    {
        constant        = [CDOConstant constant];
        constant.key    = key;
        constant.value  = [DNAppConstants constantValue:key];
        [constant saveContext];
        DLog(LL_Debug, LD_CoreData, @"key=%@, value=%@", constant.key, constant.value);
    }

    return constant.value;
}

+ (void)reloadAllConstants
{
    NSDictionary*   dict = [DNAppConstants plistDict];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL *stop)
     {
         CDOConstant*    constant = [CDOConstant constantFromKey:key];
         if (constant == nil)
         {
             constant.key   = key;
         }
         
         constant.value  = [DNAppConstants constantValue:key];
         [constant saveContext];
     }];
    
    [CDOConstant saveContext];
}

@end
