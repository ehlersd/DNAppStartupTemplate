//
//  AppDelegate.h
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "DNApplicationProtocol.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, DNApplicationProtocol>
{
}

@property (strong, nonatomic) UIWindow *window;

+ (BOOL)isRunningUnitTests;

- (void)addBugButton:(UIView*)view;
- (void)removeBugButton:(UIView*)view;

@end
