//
//  UIColor+Alpha.m
//  stellenmarkt
//
//  Created by Valentin Filip on 4/24/13.
//  Copyright (c) 2013 Stellenmarkt. All rights reserved.
//

#import "UIColor+Alpha.h"

@implementation UIColor (Alpha)

- (UIColor *)colorByChangingAlpha:(CGFloat)alpha {
    CGColorRef oldColor = CGColorCreateCopyWithAlpha([self CGColor], alpha);
    UIColor *newColor = [UIColor colorWithCGColor:oldColor];
    CGColorRelease(oldColor);
    
    return newColor;
}

- (UIColor *)lighterColor {
    float h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:MIN(b * 1.3, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColor {
    float h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.9
                               alpha:a];
    return nil;
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
    
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

// Returns a UIColor by scanning the string for a hex number and passing that to +[UIColor colorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters

/*
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSString *hexString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
	NSScanner *scanner = [NSScanner scannerWithString:hexString];
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum]) return nil;
	return [self colorWithRGBHex:hexNum];
}
*/

+ (NSString *)stringFromUIColor:(UIColor *)color {
    return [NSString stringWithFormat:@"%@", color ];
}

+ (UIColor*)colorFromNSString:(NSString *)string {
    if (!string) {
        return nil;
    }
    
    // The string should be something like "UIDeviceRGBColorSpace 0.5 0 0.25 1
    NSArray *values = [string componentsSeparatedByString:@" "];
    CGFloat red = [[values objectAtIndex:1] floatValue];
    CGFloat green = [[values objectAtIndex:2] floatValue];
    CGFloat blue = [[values objectAtIndex:3] floatValue];
    CGFloat alpha = [[values objectAtIndex:4] floatValue];
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    return color;
}

@end
