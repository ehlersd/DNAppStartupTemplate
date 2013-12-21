//
//  ViewController.m
//  CustomTransitions
//
//  Created by Tope Abayomi on 02/09/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "PresentingViewController.h"
#import "ADVAnimationController.h"
#import "PresentedViewController.h"
#import "DropAnimationController.h"
#import "ZoomAnimationController.h"

@interface PresentingViewController ()

@property (nonatomic, strong) id<ADVAnimationController> animationController;

@end

@implementation PresentingViewController

- (void)viewDidLoad
{

    UIColor* mainColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    
    NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0f];
    
    self.elementContainer.backgroundColor = [UIColor whiteColor];
    self.elementContainer.layer.cornerRadius = 3.0f;
    
    self.iconImageContainer.backgroundColor = mainColor;
    self.iconImageContainer.layer.cornerRadius = 3.0f;
    
    self.iconImageView.image = [UIImage imageNamed:@"check"];
    
    self.button1.backgroundColor = mainColor;
    self.button1.layer.cornerRadius = 3.0f;
    self.button1.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.button1 setTitle:@"TRANSITION 1" forState:UIControlStateNormal];
    [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button1 setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [self.button1 addTarget:self action:@selector(showNewController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.button2.backgroundColor = mainColor;
    self.button2.layer.cornerRadius = 3.0f;
    self.button2.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.button2 setTitle:@"TRANSITION 2" forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [self.button2 addTarget:self action:@selector(showNewController:) forControlEvents:UIControlEventTouchUpInside];
   
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)showNewController:(id)sender{
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
    UIViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"PresentedViewController"];

    if(sender == self.button1){
        self.animationController = [[ZoomAnimationController alloc] init];
    }else{
        self.animationController = [[DropAnimationController alloc] init];
    }
    
    controller.transitioningDelegate  = self;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    self.animationController.isPresenting = YES;
    
    return self.animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animationController.isPresenting = NO;
    
    return self.animationController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
