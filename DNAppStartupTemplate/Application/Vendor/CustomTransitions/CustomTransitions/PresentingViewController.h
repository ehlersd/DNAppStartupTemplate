//
//  ViewController.h
//  CustomTransitions
//
//  Created by Tope Abayomi on 02/09/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentingViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UIView * elementContainer;

@property (nonatomic, weak) IBOutlet UIButton *button1;

@property (nonatomic, weak) IBOutlet UIButton *button2;

@property (nonatomic, weak) IBOutlet UIImageView* iconImageView;

@property (nonatomic, weak) IBOutlet UIView* iconImageContainer;

@end
