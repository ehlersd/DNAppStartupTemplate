//
//  ColorPickerViewController.h
//
//
//  Created by Valentin Filip on 8/1/13.
//  Copyright (c) 2013 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ColorPickerDelegate;




@interface ColorPickerViewController : UIViewController

@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, assign) id<ColorPickerDelegate> delegate;

@end





@protocol ColorPickerDelegate <NSObject>

- (void)didSelectColor:(UIColor *)color;

@end