//
//  AppThemeManager.m
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import "AppThemeManager.h"

#import "CDOConstant.h"

@implementation AppThemeManager

+ (NSString*)themeName
{
    NSString*   retval  = [AppConstants appTheme];
    if ([retval length] == 0)
    {
        retval = @"Base";
    }

    return [NSString stringWithFormat:@"AppTheme%@", retval];
}

@end
