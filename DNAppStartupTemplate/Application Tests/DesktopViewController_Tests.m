//
//  LOGWelcomeViewController_Tests.m
//  Phoenix
//
//  Created by Darren Ehlers on 9/26/13.
//  Copyright (c) 2013 LBi. All rights reserved.
//

#import "Kiwi.h"
#import "KWSpec+WaitFor.h"

#import "AppDelegate.h"
#import "DesktopViewController.h"

SPEC_BEGIN(DesktopViewController_Tests)

describe(@"The view controller", ^
{
    context(@"when created", ^
            {
                __block DesktopViewController*   sut  = nil;

                beforeEach(^
                           {
                               sut    = [[DesktopViewController alloc] initWithNibName:nil bundle:nil];
                           });

                afterEach(^
                          {
                              sut   = nil;
                          });

                it(@"should not be nil", ^
                   {
                       [[sut should] beNonNil];
                   });
            });
    context(@"when displayed", ^
            {
                __block DesktopViewController*   sut  = nil;

                beforeEach(^
                           {
                               __block DesktopViewController*   isut = nil;
                               isut    = [[DesktopViewController alloc] initWithNibName:nil bundle:nil];

                               [[[DNUtilities appDelegate] rootViewController] presentViewController:isut
                                                                                            animated:YES
                                                                                          completion:^
                                {
                                    sut = isut;
                                }];
                           });

                afterEach(^
                          {
                              [sut dismissViewControllerAnimated:NO completion:^
                               {
                                   sut   = nil;
                               }];
                          });

                it(@"should not be nil", ^
                   {
                       [[expectFutureValue(sut) shouldEventuallyBeforeTimingOutAfter(1.0f)] beNonNil];
                   });
                it(@"should indicate loaded", ^
                   {
                       [[expectFutureValue(theValue(sut.isViewLoaded)) shouldEventuallyBeforeTimingOutAfter(1.0f)] beTrue];
                   });
            });
});

SPEC_END
