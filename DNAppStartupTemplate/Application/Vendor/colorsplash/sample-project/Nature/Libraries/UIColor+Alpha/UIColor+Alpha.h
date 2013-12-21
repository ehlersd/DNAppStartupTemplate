//
//  UIColor+Alpha.h
//  stellenmarkt
//
//  Created by Valentin Filip on 4/24/13.
//  Copyright (c) 2013 Stellenmarkt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Alpha)

- (UIColor *)colorByChangingAlpha:(CGFloat)alpha;
- (UIColor *)lighterColor;
- (UIColor *)darkerColor;
//+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (NSString *)stringFromUIColor:(UIColor *)color;
+ (UIColor *)colorFromNSString:(NSString *)string;

@end
