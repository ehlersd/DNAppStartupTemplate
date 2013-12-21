//
//  Utils.h
//  Nature
//
//  Created by Tope Abayomi on 12/09/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void)customizeView:(UIView *)view;

+ (UIImage*)createGradientImageFromColor:(UIColor *)startColor toColor:(UIColor *)endColor withSize:(CGSize)size;

@end
