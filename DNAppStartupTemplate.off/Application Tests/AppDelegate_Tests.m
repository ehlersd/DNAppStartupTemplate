//
//  AppDelegate_Tests.m
//  Phoenix
//
//  Created by Darren Ehlers on 11/22/13.
//  Copyright (c) 2013 Table Project. All rights reserved.
//

#import "Kiwi.h"
#import "KWSpec+WaitFor.h"

#import "AppDelegate.h"

@interface AppDelegate (UnitTesting)

+ (BOOL)isRunningUnitTests;

@end

@implementation AppDelegate (UnitTesting)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (BOOL)isRunningUnitTests
{
    return YES;
}

#pragma clang diagnostic pop

@end

SPEC_BEGIN(AppDelegate_Tests)

describe(@"The AppDelegate", ^
{
    context(@"when created", ^
            {
                __block AppDelegate*   sut  = nil;

                beforeEach(^
                           {
                               sut  = [[AppDelegate alloc] init];
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
});

SPEC_END
