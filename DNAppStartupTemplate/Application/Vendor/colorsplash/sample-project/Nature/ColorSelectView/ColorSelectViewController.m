//
//  ColorSelectViewController.m
//
//
//  Created by Valentin Filip on 8/1/13.
//  Copyright (c) 2013 AppDesignVault. All rights reserved.
//

#import "ColorSelectViewController.h"
#import "ColorPickerViewController.h"
#import "AppDelegate.h"
#import "UIColor+Alpha.h"
#import "Utils.h"

@interface ColorSelectViewController ()

@property (nonatomic, strong) NSIndexPath *currentIndex;

@end





@implementation ColorSelectViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];

    NSString* color = [[NSUserDefaults standardUserDefaults] objectForKey:@"kBlurredGradientStartColor"];
    
    if(!color){
    
        NSString* startColor = [UIColor stringFromUIColor:[UIColor greenColor]];
        NSString* endColor = [UIColor stringFromUIColor:[UIColor yellowColor]];
        
        [[NSUserDefaults standardUserDefaults] setObject:startColor forKey:@"kBlurredGradientStartColor"];
        [[NSUserDefaults standardUserDefaults] setObject:endColor forKey:@"kBlurredGradientEndColor"];
    }
    
    [Utils customizeView:self.view];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [Utils customizeView:self.view];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0: {
            static NSString *CellIdentifier = @"Cell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            UILabel *label = (UILabel *)[cell viewWithTag:1];
            UIView *colorView = [cell viewWithTag:2];
            
            if (!indexPath.row) {
                UIColor *startColor = [UIColor colorFromNSString:[[NSUserDefaults standardUserDefaults] objectForKey:@"kBlurredGradientStartColor"]];
                
                label.text = @"Starting Color";
                colorView.backgroundColor = startColor;
            } else {
                UIColor *endColor = [UIColor colorFromNSString:[[NSUserDefaults standardUserDefaults] objectForKey:@"kBlurredGradientEndColor"]];
                
                label.text = @"End Color";
                colorView.backgroundColor = endColor;
            }
            
            break;
        }
        case 1: {
            static NSString *CellIdentifier = @"PresetCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            cell.textLabel.text = @"Presets";
            
            break;
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.section) {
        case 0:
            _currentIndex = indexPath;
            [self performSegueWithIdentifier:@"ColorPicker" sender:self];
            break;
        case 1:
            _currentIndex = nil;
            [self performSegueWithIdentifier:@"PresetPicker" sender:self];
            break;
        default:
            break;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ColorPicker"]) {
        ColorPickerViewController *destVC = segue.destinationViewController;
        if (!_currentIndex.row) {
            destVC.currentColor = [UIColor colorFromNSString:[[NSUserDefaults standardUserDefaults] objectForKey:@"kBlurredGradientStartColor"]];
        } else {
            destVC.currentColor = [UIColor colorFromNSString:[[NSUserDefaults standardUserDefaults] objectForKey:@"kBlurredGradientEndColor"]];
        }
        
        destVC.delegate = self;
    }
}



- (void)didSelectColor:(UIColor *)color {
    NSString *colorString = [UIColor stringFromUIColor:color];
    if (!_currentIndex.row) {
        [[NSUserDefaults standardUserDefaults] setObject:colorString forKey:@"kBlurredGradientStartColor"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:colorString forKey:@"kBlurredGradientEndColor"];
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kBlurredBackground"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kBlurredGradientNewColors"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentIndex];
    UIView *colorView = [cell viewWithTag:2];
    colorView.backgroundColor = color;
    
    [Utils customizeView:self.view];
    
}

@end
