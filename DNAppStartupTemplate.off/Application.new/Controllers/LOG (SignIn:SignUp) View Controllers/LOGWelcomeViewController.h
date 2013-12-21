//
//  LOGWelcomeViewController.h
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EZForm/EZForm.h>

#import "DNTextField.h"
#import "DNLabel.h"

#import "DNStateViewController.h"

#import "SHEmailValidationTextField.h"

#define LOGWelcomeViewViewStateWelcome              @"Welcome"

#define LOGWelcomeViewViewStateSignIn               @"SignIn"
#define LOGWelcomeViewViewStateSignInValid          @"SignInValid"
#define LOGWelcomeViewViewStateSignInKeyboard       @"SignInKeyboard"
#define LOGWelcomeViewViewStateSignInKeyboardValid  @"SignInKeyboardValid"
#define LOGWelcomeViewViewStateSignInProcessing     @"SignInProcessing"
#define LOGWelcomeViewViewStateSignInError          @"SignInError"
#define LOGWelcomeViewViewStateSignInSuccess        @"SignInSuccess"

#define LOGWelcomeViewViewStateResetPassword                @"ResetPassword"
#define LOGWelcomeViewViewStateResetPasswordValid           @"ResetPasswordValid"
#define LOGWelcomeViewViewStateResetPasswordKeyboard        @"ResetPasswordKeyboard"
#define LOGWelcomeViewViewStateResetPasswordKeyboardValid   @"ResetPasswordKeyboardValid"
#define LOGWelcomeViewViewStateResetPasswordProcessing      @"ResetPasswordProcessing"
#define LOGWelcomeViewViewStateResetPasswordError           @"ResetPasswordError"
#define LOGWelcomeViewViewStateResetPasswordSuccess         @"ResetPasswordSuccess"

@class LOGWelcomeViewController;

typedef void(^LOGWelcomeViewControllerLoginBlock)(LOGWelcomeViewController* viewController);

@interface LOGWelcomeViewController : DNStateViewController

@property (strong, nonatomic) IBOutlet  EZForm*     signInForm;
@property (strong, nonatomic) IBOutlet  EZForm*     resetPasswordForm;

@property (weak, nonatomic) IBOutlet UIImageView*   backgroundImg;
@property (weak, nonatomic) IBOutlet UIView*        contentView;

@property (weak, nonatomic) IBOutlet UIImageView*   logoImg;

@property (weak, nonatomic) IBOutlet UIButton*      signInBtn;
@property (weak, nonatomic) IBOutlet UIButton*      signUpBtn;
@property (weak, nonatomic) IBOutlet UIButton*      resetPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton*      forgotPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton*      cancelResetBtn;

@property (weak, nonatomic) IBOutlet SHEmailValidationTextField*    usernameTxtfld;
@property (weak, nonatomic) IBOutlet DNTextField*                   passwordTxtfld;

@property (weak, nonatomic) IBOutlet SHEmailValidationTextField*    resetUsernameTxtfld;

@property (weak, nonatomic) IBOutlet UIView*        disabledView;
@property (weak, nonatomic) IBOutlet UIImageView*   disabledSpinnerImg;

@property (weak, nonatomic) IBOutlet UIView*        errorBanner;
@property (weak, nonatomic) IBOutlet UIView*        errorBannerBubbleView;
@property (weak, nonatomic) IBOutlet DNLabel*       errorBannerLabel;
@property (weak, nonatomic) IBOutlet UIImageView*   errorBannerNipple;

@property (strong, nonatomic) LOGWelcomeViewControllerLoginBlock    loginBlock;

- (void)updateViewsForFormValidity;
- (void)setForm:(EZForm*)form firstResponder:(UIView*)firstResponder;

- (IBAction)signInAction:(id)sender;
- (IBAction)signUpAction:(id)sender;
- (IBAction)resetPasswordAction:(id)sender;
- (IBAction)forgotPasswordAction:(id)sender;
- (IBAction)cancelResetAction:(id)sender;

@end
