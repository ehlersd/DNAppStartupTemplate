//
//  NavigationViewController.h
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import "DNNavigationController.h"

@protocol NavigationViewControllerProtocol;

@interface NavigationViewController : DNNavigationController

@property (weak, nonatomic) id<NavigationViewControllerProtocol>  rootViewController;

- (void)presentMenuViewController;

@end

@protocol NavigationViewControllerProtocol <NSObject>

@required
- (void)presentMenuViewController;
- (void)hideMenuViewController;

@optional
- (void)panGestureRecognized:(UIPanGestureRecognizer*)recognizer;

@end