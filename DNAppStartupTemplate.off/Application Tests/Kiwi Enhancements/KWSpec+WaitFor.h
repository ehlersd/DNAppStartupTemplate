//
//  KWSpec+WaitFor.h
//  Phoenix
//
//  Created by Darren Ehlers on 10/7/13.
//  Copyright (c) 2013 LBi. All rights reserved.
//

#import "KWSpec.h"

@interface KWSpec (WaitFor)

+ (void) waitWithTimeout:(NSTimeInterval)timeout forCondition:(BOOL(^)())conditionalBlock;

@end
