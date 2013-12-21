//
//  CDConstantModel.h
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DNModel.h"
#import "DNModelWatchObject.h"

#import "CDOConstant.h"

@interface CDConstantModel : DNModel

- (DNModelWatchObject*)getFromKey:(NSString*)key didChange:(DNModelWatchObjectDidChangeHandlerBlock)handler;

@end
