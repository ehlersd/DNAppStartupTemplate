//
//  iPadRootViewController.m
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import "iPadRootViewController.h"

#import "NavigationViewController.h"

@interface iPadRootViewController ()

@end

@implementation iPadRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    NavigationViewController*   navViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    navViewController.rootViewController   = self;
    
    self.contentViewController  = navViewController;
    //self.contentViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.menuViewController     = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    
    self.liveBlur                   = YES;
    self.liveBlurBackgroundStyle    = REFrostedViewControllerLiveBackgroundStyleDark;

    self.menuViewSize    = CGSizeMake(500.0f, self.contentViewController.view.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

    self.menuViewSize    = CGSizeMake(500.0f, self.contentViewController.view.frame.size.height);
}

@end
