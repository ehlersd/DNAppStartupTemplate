//
//  ColorPickerViewController.m
//
//
//  Created by Valentin Filip on 8/1/13.
//  Copyright (c) 2013 AppDesignVault. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "KZColorPicker.h"
#import "AppDelegate.h"
#import "Utils.h"


@interface ColorPickerViewController ()

@end

@implementation ColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Utils customizeView:self.view];
    
    CGRect bounds = self.view.bounds;

    
    KZColorPicker *picker = [[KZColorPicker alloc] initWithFrame:bounds];
    picker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	picker.selectedColor = self.currentColor;
    picker.oldColor = self.currentColor;
    picker.backgroundColor = [UIColor clearColor];
    [picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:picker];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = doneBtn;
}


#pragma mark - Actions

- (void)pickerChanged:(KZColorPicker *)cp
{
    self.currentColor = cp.selectedColor;
}


- (void)done:(id)sender {
    if ([_delegate respondsToSelector:@selector(didSelectColor:)]) {
        [_delegate didSelectColor:_currentColor];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
