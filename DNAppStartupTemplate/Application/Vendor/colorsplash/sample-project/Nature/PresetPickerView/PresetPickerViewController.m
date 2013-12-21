//
//  PresetPickerViewController.m
//
//
//  Created by Valentin Filip on 8/7/13.
//  Copyright (c) 2013 AppDesignVault. All rights reserved.
//

#import "PresetPickerViewController.h"
#import "Utils.h"
#import "DataSource.h"
#import "UIColor+Alpha.h"
#import "UIImage+iPhone5.h"

@interface PresetPickerViewController ()

@property (nonatomic, strong) NSArray *presets;

@end

@implementation PresetPickerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.presets = [DataSource settings][@"backgrounds"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.layout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
    self.layout.minimumInteritemSpacing = 2;
    self.layout.minimumLineSpacing = 5;
    
    [self.collectionView reloadData];
    
    [Utils customizeView:self.view];
}


#pragma mark -
#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.presets count];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.presets[section][@"rows"] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                         withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    
    NSString *title = [_presets[indexPath.section][@"title"] uppercaseString];
    UILabel *titleLabel = (UILabel *)[headerView viewWithTag:1];
    titleLabel.font = [UIFont fontWithName:@"Avenir" size:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = title;

    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"CollectionCell";
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    id item = _presets[indexPath.section][@"rows"][indexPath.row];
    if ([item isKindOfClass:[NSString class]]) {
        UIImage *bkgImage = [[UIImage imageNamed:item] imageScaledToSize:CGSizeMake(90, 160)];
        cell.backgroundColor = [UIColor colorWithPatternImage:bkgImage];
    } else {
        NSDictionary *color = item[@"startColor"];
        UIColor *startColor = [UIColor colorWithRed:[color[@"red"] floatValue] green:[color[@"green"] floatValue] blue:[color[@"blue"] floatValue] alpha:1];
        color = item[@"endColor"];
        UIColor *endColor = [UIColor colorWithRed:[color[@"red"] floatValue] green:[color[@"green"] floatValue] blue:[color[@"blue"] floatValue] alpha:1];
        UIImage *bkgImage = [Utils createGradientImageFromColor:startColor toColor:endColor withSize:cell.bounds.size];
        cell.backgroundColor = [UIColor colorWithPatternImage:bkgImage];
    }
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90, 160);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id item = _presets[indexPath.section][@"rows"][indexPath.row];
    
    if ([item isKindOfClass:[NSString class]]) {
        [[NSUserDefaults standardUserDefaults] setObject:item forKey:@"kBlurredBackground"];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kBlurredBackground"];
        
        NSDictionary *color = item[@"startColor"];
        UIColor *startColor = [UIColor colorWithRed:[color[@"red"] floatValue] green:[color[@"green"] floatValue] blue:[color[@"blue"] floatValue] alpha:1];
        [[NSUserDefaults standardUserDefaults] setObject:[UIColor stringFromUIColor:startColor] forKey:@"kBlurredGradientStartColor"];

        color = item[@"endColor"];
        UIColor *endColor = [UIColor colorWithRed:[color[@"red"] floatValue] green:[color[@"green"] floatValue] blue:[color[@"blue"] floatValue] alpha:1];
        [[NSUserDefaults standardUserDefaults] setObject:[UIColor stringFromUIColor:endColor] forKey:@"kBlurredGradientEndColor"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kBlurredGradientNewColors"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [Utils customizeView:self.view];
}


@end
