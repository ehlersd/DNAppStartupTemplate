//
//  MainViewController.m
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import "MainViewController.h"

#import "NavigationViewController.h"
#import "LOGWelcomeViewController.h"

#import "DNUtilities.h"
#import "AppDelegate.h"

#import "UIScrollView+ScrollDirection.h"

@interface MainViewController ()
{
    UIStatusBarStyle    statusBarStyle;

    double  navBarHeight;
    double  navBarPosition;
    double  navBarOffset;

    CGPoint lastContentOffset;
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return statusBarStyle;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    statusBarStyle  = UIStatusBarStyleDefault;

    navBarHeight    = 64.0f;
    navBarPosition  = 42.0f;
    navBarOffset    = 0.0f;

    self.automaticallyAdjustsScrollViewInsets   = YES;

    [self setNeedsStatusBarAppearanceUpdate];

    UIBarButtonItem*    menuBarItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btnNavBarMenu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(menuButtonAction:)];
    [self.navigationItem setLeftBarButtonItem:menuBarItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [((AppDelegate*)[DNUtilities appDelegate]) addBugButton:self.view];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [((AppDelegate*)[DNUtilities appDelegate]) removeBugButton:self.view];

    [super viewWillDisappear:animated];
}

- (void)updateNavigationBarStyle
{
    statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Actions

- (void)menuButtonAction:(id)sender
{
    NavigationViewController*   navController   = (NavigationViewController*)self.navigationController;

    [navController presentMenuViewController];
}

- (IBAction)testBtn:(id)sender
{
}

@end
