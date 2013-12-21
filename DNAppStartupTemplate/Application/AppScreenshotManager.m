//
//  AppScreenshotManager.m
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#if CREATING_SCREENSHOTS

#import "AppScreenshotManager.h"
#import "KSScreenshotAction.h"

#import "DNUtilities.h"
#import "Nocilla.h"
#import "KPAViewControllerTestHelper.h"

const CGFloat   kScreenshotDelayTimeout = 5.0f;

//Private API to programmatically force the simulator into a different orientation
//Don't ship this to the App Store!
@interface UIDevice ()

- (void)setOrientation:(UIInterfaceOrientation)orientation;

@end

@implementation AppScreenshotManager

- (void)doMyPresentViewController:(UIViewController*)vc
                       completion:(void(^)(BOOL finished))completion
{
    vc.view.backgroundColor = [UIColor clearColor];

    [[DNUtilities appDelegate] rootViewController].modalPresentationStyle = UIModalPresentationCurrentContext;
    [[[DNUtilities appDelegate] rootViewController] presentViewController:vc
                                                                 animated:NO
                                                               completion:^
     {
         completion(YES);
     }];
}

- (NSString*)fullNameWithViewName:(NSString*)viewName
                     screenNumber:(NSUInteger)screenNumber
                       screenName:(NSString*)screenName
{
    return [NSString stringWithFormat:@"%@-%03d-%@", viewName, screenNumber, screenName];
}

- (void)setupScreenshotActions
{
    NSUInteger  screenNumber    = 1;

    [[LSNocilla sharedInstance] start];

    {
        KSScreenshotAction* synchronousAction = [KSScreenshotAction actionWithName:[self fullNameWithViewName:@"LOGWelcomeView"
                                                                                                 screenNumber:screenNumber++
                                                                                                   screenName:@"Welcome"]
                                                                      asynchronous:YES
                                                                       actionBlock:^
                                                 {
                                                     [self doMyPresentViewController:[self LOGWelcomeVC] completion:^(BOOL finished)
                                                      {
                                                          [DNUtilities runAfterDelay:kScreenshotDelayTimeout block:^
                                                           {
                                                               [self actionIsReady];
                                                           }];
                                                      }];
                                                 }
                                                                      cleanupBlock:^
                                                 {
                                                     [[LSNocilla sharedInstance] clearStubs];
                                                 }];

        [self addScreenshotAction:synchronousAction];
    }

    [[LSNocilla sharedInstance] stop];
}

@end

#endif
