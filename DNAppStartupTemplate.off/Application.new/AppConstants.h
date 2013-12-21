//
//  AppConstants.h
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import "DNAppConstants.h"

@interface AppConstants : DNAppConstants

+ (void)reloadAllConstants;

+ (BOOL)resetConstants;
+ (NSUInteger)appStoreID;
    
+ (NSString*)hockeyAppLiveID;
+ (NSString*)hockeyAppBetaID;
+ (NSString*)flurryApiKey;
+ (NSString*)crashlyticsApiKey;

+ (NSString*)appTheme;

/*
+ (UIColor*)colorDefaultTabContentBG;

+ (BOOL)flagBioTitlingForceUpper;

+ (UIFont*)fontSystemMenuAbout;

+ (CGSize)sizePeoplePartnersThumbnails;

+ (double)noteNavBarCornerRadius;
*/

@end
