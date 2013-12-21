//
//  CDOConstantModel_Tests.m
//  Phoenix
//
//  Created by Darren Ehlers on 9/26/13.
//  Copyright (c) 2013 LBi. All rights reserved.
//

#import "Kiwi.h"
#import "KWSpec+WaitFor.h"

#import "DNUtilities.h"
#import "MainAPIClient.h"
#import "CDConstantModel.h"

static NSString * const kMainAPIBaseURLString = @"http://phoenixconstantsunittests.apiary.io";

SPEC_BEGIN(CDOConstantModel_Tests)

describe(@"With our model", ^
{
    context(@"when fetching all entities", ^
            {
                __block CDConstantModel*    model           = nil;
                __block NSArray*            constantsArray  = nil;
                
                beforeAll(^
                          {
                              [[DNUtilities appDelegate] setPersistentStorePrefix:@"CDOConstantModel_Tests"];
                              [[DNUtilities appDelegate] disableURLCache];
                              //[[DNUtilities appDelegate] deletePersistentStore];
                              [MainAPIClient baseURLString:kMainAPIBaseURLString];
                          });
                
                beforeEach(^
                          {
                              model = [CDConstantModel model];
                              [model getAllOnResult:^(DNModelWatchObjects* watch, NSArray* objects)
                               {
                                   // DME: Wait until actual content is returned
                                   if ([objects count] == 0) {   return; }
                                   
                                   constantsArray = objects;
                               }];
                          });
                
                afterEach(^
                           {
                               model            = nil;
                               constantsArray   = nil;
                               
                               [[DNUtilities appDelegate] deletePersistentStore];
                           });
                
                it(@"the array should not be nil", ^
                   {
                       [[expectFutureValue(constantsArray) shouldEventuallyBeforeTimingOutAfter(30.0f)] beNonNil];
                   });
                it(@"the array should contain 2 entities", ^
                   {
                       [[expectFutureValue(constantsArray) shouldEventuallyBeforeTimingOutAfter(30.0f)] haveCountOf:2];
                   });
                it(@"the array should contain CDOConstant entities", ^
                   {
                       [[expectFutureValue(constantsArray[0]) shouldEventuallyBeforeTimingOutAfter(30.0f)] beKindOfClass:[NSManagedObject class]];
                       [[expectFutureValue(constantsArray[1]) shouldEventuallyBeforeTimingOutAfter(30.0f)] beKindOfClass:[NSManagedObject class]];
                   });
            });
});

SPEC_END
