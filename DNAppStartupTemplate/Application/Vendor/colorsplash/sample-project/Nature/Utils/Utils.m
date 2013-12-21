//
//  Utils.m
//  Nature
//
//  Created by Tope Abayomi on 12/09/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "Utils.h"
#import "UIColor+Alpha.h"


@implementation Utils

+ (void)customizeView:(UIView *)view
{

    UIImage *backgroundImage = [self viewBackground];
   
    [view setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
}

+ (UIImage *)viewBackground
{
    UIImage *image;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kBlurredBackground"]) {
        image = [UIImage imageNamed:[[NSUserDefaults standardUserDefaults] objectForKey:@"kBlurredBackground"]];
    } else {
        UIColor *startColor = [UIColor colorFromNSString:[[NSUserDefaults standardUserDefaults] objectForKey:@"kBlurredGradientStartColor"]];
        UIColor *endColor = [UIColor colorFromNSString:[[NSUserDefaults standardUserDefaults] objectForKey:@"kBlurredGradientEndColor"]];
        image = [self gradientImageWithStartColor:startColor andEndColor:endColor];
    }
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero];
    return image;
}

+ (UIImage *)gradientImageWithStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    NSString *imageName = scale > 1 ? @"background@2x.png" : @"background.png";
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (!image || [[NSUserDefaults standardUserDefaults] boolForKey:@"kBlurredGradientNewColors"]) {
        
        startColor = startColor ? startColor : [UIColor colorWithRed:0.07f green:0.55f blue:0.52f alpha:1.00f];
        endColor = endColor ? endColor : [UIColor colorWithRed:0.33f green:0.16f blue:0.80f alpha:1.00f];
        
        [[NSUserDefaults standardUserDefaults] setObject:[UIColor stringFromUIColor:startColor] forKey:@"kBlurredGradientStartColor"];
        [[NSUserDefaults standardUserDefaults] setObject:[UIColor stringFromUIColor:endColor] forKey:@"kBlurredGradientEndColor"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        image = [self createGradientImageFromColor:startColor toColor:endColor withSize:screenRect.size];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kBlurredGradientNewColors"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    } else {
        image = [UIImage imageWithContentsOfFile:filePath];
    }
    
    return image;
}

+ (UIImage*)createGradientImageFromColor:(UIColor *)startColor toColor:(UIColor *)endColor withSize:(CGSize)size {
    
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0,0,size.width,size.height);
    drawLinearGradient(currentContext, fillRect, startColor.CGColor, endColor.CGColor);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}



@end
