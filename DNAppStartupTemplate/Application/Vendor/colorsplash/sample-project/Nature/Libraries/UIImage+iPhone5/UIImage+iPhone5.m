//
//  UIImage+iPhone5.m
//  
//
//  Created by Valentin Filip on 9/24/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "UIImage+iPhone5.h"

@implementation UIImage (iPhone5)

+ (BOOL)isTall {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone
        && [UIScreen mainScreen].bounds.size.height == 568)
    {
        return YES;
    }
    return NO;
}

+ (UIImage *)tallImageNamed:(NSString *)name {
    
    UIImage *image = nil;
    if ([self isTall]) {
        NSString *fileName = [[[NSFileManager defaultManager] displayNameAtPath:name] stringByDeletingPathExtension];
        NSString *extension = [name pathExtension];
        
        NSString *nameTall = [NSString stringWithFormat:@"%@-568h", fileName];
        if (extension && ![extension isEqualToString:@""]) {
            nameTall = [nameTall stringByAppendingFormat:@".%@", extension];
        }
        image = [UIImage imageNamed:nameTall];
    }
    
    if (!image) {
        image = [UIImage imageNamed:name];
    }
    
    return image;
}

- (CGFloat)aspectFitHeightForWidth:(CGFloat)width {
    CGFloat scaleFactor;
    if( self.size.width > width ) {
        scaleFactor = width / self.size.width;
    } else {
        scaleFactor = self.size.width / width;
    }
    
    return self.size.height * scaleFactor;
}

- (UIImage *)imageScaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)crop:(CGRect)rect {
    rect = CGRectMake(rect.origin.x * self.scale,
                      rect.origin.y * self.scale,
                      rect.size.width * self.scale,
                      rect.size.height * self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

@end
