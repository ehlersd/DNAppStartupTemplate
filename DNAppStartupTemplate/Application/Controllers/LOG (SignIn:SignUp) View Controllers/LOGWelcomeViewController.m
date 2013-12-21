//
//  LOGWelcomeViewController.m
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import <AFOAuth2Client/AFOAuth2Client.h>

#import "LOGWelcomeViewController.h"

#import "DNTheme.h"
#import "DNUtilities.h"
#import "AppDelegate.h"

#import "UIApplication+AppDimensions.h"
#import "UIColor-Expanded.h"
#import "UIFont+Custom.h"
#import "AFJSONRequestOperation.h"

// SignIn Form Fields
static NSString* const  EZLOGWelcomeViewUsernameKey = @"username";
static NSString* const  EZLOGWelcomeViewPasswordKey = @"password";

// Reset Password Form Fields
static NSString* const  EZLOGWelcomeViewResetUsernameKey = @"resetUsername";

@interface LOGWelcomeViewController () <EZFormDelegate>
{
    BOOL    formClosingFlag;
}

@end

@implementation LOGWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    nibNameOrNil    = [DNThemeManager customizeNibNameWithClass:NSStringFromClass([self class]) withGroup:@"LOG" andScreen:@"WelcomeView"];

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        [self initializeSignInForm];
        [self initializeResetPasswordForm];
    }

    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNeedsStatusBarAppearanceUpdate];

    UIViewAutoresizing  controlMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.autoresizingMask   = controlMask;

    [[self.signInForm formFieldForKey:EZLOGWelcomeViewUsernameKey] useTextField:self.usernameTxtfld];
    [[self.signInForm formFieldForKey:EZLOGWelcomeViewPasswordKey] useTextField:self.passwordTxtfld];

    [[self.resetPasswordForm formFieldForKey:EZLOGWelcomeViewResetUsernameKey] useTextField:self.resetUsernameTxtfld];

    self.usernameTxtfld.bubbleFillColor         = [UIColor colorWithHexString:@"eaeaeae6"];
    self.usernameTxtfld.bubbleTitleColor        = [UIColor grayColor];
    self.usernameTxtfld.bubbleSuggestionColor   = [UIColor blackColor];

    self.resetUsernameTxtfld.bubbleFillColor        = [UIColor colorWithHexString:@"eaeaeae6"];
    self.resetUsernameTxtfld.bubbleTitleColor       = [UIColor grayColor];
    self.resetUsernameTxtfld.bubbleSuggestionColor  = [UIColor blackColor];

    if ([DNUtilities isDeviceIPad] == YES)
    {
        self.usernameTxtfld.placeholder = NSLocalizedStringFromTable(@"99Q-mZ-vkn.placeholder", @"LOGWelcomeViewController~ipad", nil);
        self.passwordTxtfld.placeholder = NSLocalizedStringFromTable(@"kBK-OR-pxw.placeholder", @"LOGWelcomeViewController~ipad", nil);

        self.resetUsernameTxtfld.placeholder = NSLocalizedStringFromTable(@"EWd-8o-DWf.placeholder", @"LOGWelcomeViewController~ipad", nil);
    }
    else
    {
        self.usernameTxtfld.placeholder = NSLocalizedStringFromTable(@"ne1-JR-7Aa.placeholder", @"LOGWelcomeViewController", nil);
        self.passwordTxtfld.placeholder = NSLocalizedStringFromTable(@"Wzm-Fe-U8G.placeholder", @"LOGWelcomeViewController", nil);

        self.resetUsernameTxtfld.placeholder = NSLocalizedStringFromTable(@"Pth-JD-7pU.placeholder", @"LOGWelcomeViewController", nil);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.contentView.alpha              = 0.0f;
    self.errorBanner.alpha              = 0.0f;
    self.errorBannerBubbleView.alpha    = 0.0f;
    self.errorBannerLabel.alpha         = 0.0f;
    self.errorBannerNipple.alpha        = 0.0f;
    self.signInBtn.alpha                = 0.0f;
    self.signUpBtn.alpha                = 0.0f;
    self.resetPasswordBtn.alpha         = 0.0f;
    self.forgotPasswordBtn.alpha        = 0.0f;
    self.cancelResetBtn.alpha           = 0.0f;
    self.usernameTxtfld.alpha           = 0.5f;
    self.passwordTxtfld.alpha           = 0.5f;
    self.resetUsernameTxtfld.alpha      = 0.5f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self changeToViewState:LOGWelcomeViewViewStateWelcome animated:YES completion:nil];
}

#pragma mark - ViewState Changes

- (void)viewStateWillAppear:(NSString*)newViewState
                   animated:(BOOL)animated
{
    [super viewStateWillAppear:newViewState animated:animated];

    [UIView animateWithDuration:0.4f animations:^
     {
         [DNThemeManager customizeButton:self.signInBtn             withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"SignIn"];
         [DNThemeManager customizeButton:self.signUpBtn             withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"SignUp"];
         [DNThemeManager customizeButton:self.resetPasswordBtn      withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"ResetPassword"];
         [DNThemeManager customizeButton:self.forgotPasswordBtn     withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"ForgotPassword"];
         [DNThemeManager customizeButton:self.cancelResetBtn        withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"CancelReset"];

         [DNThemeManager customizeTextField:self.usernameTxtfld         withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"Username"];
         [DNThemeManager customizeTextField:self.passwordTxtfld         withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"Password"];
         [DNThemeManager customizeTextField:self.resetUsernameTxtfld    withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"ResetUsername"];

         [DNThemeManager customizeView:self.errorBanner             withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"ErrorBanner"];
         [DNThemeManager customizeView:self.errorBannerBubbleView   withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"ErrorBannerBubble"];
         [DNThemeManager customizeLabel:self.errorBannerLabel       withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"ErrorBannerLabel"];
         [DNThemeManager customizeImage:self.errorBannerNipple      withGroup:@"LOG" andScreen:@"WelcomeView" andViewState:newViewState andItem:@"ErrorBannerNipple"];
     }];
}

- (void)viewStateDidAppear:(NSString*)newViewState
                  animated:(BOOL)animated
{
    [super viewStateDidAppear:newViewState animated:animated];
}

#pragma mark - setupPendingProperties

- (void)setupPendingPropertiesForAllViewStates
{
    self.backgroundImg.pendingAlpha         = 1.0f;
    self.contentView.pendingAlpha           = 1.0f;

    self.logoImg.pendingAlpha               = 0.0f;

    self.signInBtn.pendingAlpha             = 0.0f;
    self.signUpBtn.pendingAlpha             = 0.0f;
    self.resetPasswordBtn.pendingAlpha      = 0.0f;
    self.forgotPasswordBtn.pendingAlpha     = 0.0f;
    self.cancelResetBtn.pendingAlpha        = 0.0f;

    self.usernameTxtfld.pendingAlpha        = 0.0f;
    self.passwordTxtfld.pendingAlpha        = 0.0f;
    self.resetUsernameTxtfld.pendingAlpha   = 0.0f;

    self.disabledView.pendingAlpha          = 0.0f;
    self.disabledSpinnerImg.pendingAlpha    = 0.0f;

    self.errorBanner.pendingAlpha           = 0.0f;
    self.errorBannerBubbleView.pendingAlpha = 0.0f;
    self.errorBannerLabel.pendingAlpha      = 0.0f;
    self.errorBannerNipple.pendingAlpha     = 0.0f;

    self.errorBanner.pendingFrame   = (CGRect){ 20, 196, 280, 48 };
}

- (void)setupPendingPropertiesForViewStateWelcome
{
    [self setupPendingPropertiesForAllViewStates];

    self.logoImg.pendingAlpha   = 1.0f;

    self.contentView.alpha  = 1.0f;
    self.contentView.y      = self.view.frame.size.height;

    self.contentView.pendingAlpha   = 1.0f;
    self.contentView.pendingY       = ([UIApplication currentSize].height - self.contentView.frame.size.height) / 2;

    self.usernameTxtfld.x           = self.usernameTxtfld.frame.origin.x + ([UIApplication currentSize].width - self.contentView.frame.origin.x);
    self.usernameTxtfld.y           = 196;
    [self.usernameTxtfld resetPendingFrame];

    self.passwordTxtfld.x           = self.passwordTxtfld.frame.origin.x + ([UIApplication currentSize].width - self.contentView.frame.origin.x);
    self.passwordTxtfld.y           = 258;
    [self.passwordTxtfld resetPendingFrame];

    self.resetUsernameTxtfld.x      = self.resetUsernameTxtfld.frame.origin.x + ([UIApplication currentSize].width - self.contentView.frame.origin.x);
    self.resetUsernameTxtfld.y      = 196;
    [self.resetUsernameTxtfld resetPendingFrame];

    self.signInBtn.pendingAlpha     = 1.0f;

    self.signUpBtn.pendingAlpha             = 1.0f;
    self.signUpBtn.pendingTransform         = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);

    self.forgotPasswordBtn.pendingTransform = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    self.signInBtn.pendingTransform         = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
    self.cancelResetBtn.pendingTransform    = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    self.passwordTxtfld.pendingTransform    = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
    self.resetPasswordBtn.pendingTransform  = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    if ([DNUtilities isTall] == NO)
    {
        self.usernameTxtfld.y       = self.usernameTxtfld.y - 40;
        [self.usernameTxtfld resetPendingFrame];

        self.passwordTxtfld.y       = self.passwordTxtfld.y - 40;
        [self.passwordTxtfld resetPendingFrame];

        self.resetUsernameTxtfld.y  = self.resetUsernameTxtfld.y - 40;
        [self.resetUsernameTxtfld resetPendingFrame];

        self.signInBtn.y            = self.signInBtn.y - 40;
        [self.signInBtn resetPendingFrame];

        self.signUpBtn.y            = self.signUpBtn.y - 40;
        [self.signUpBtn resetPendingFrame];

        self.forgotPasswordBtn.y    = self.forgotPasswordBtn.y - 40;
        [self.forgotPasswordBtn resetPendingFrame];
    }
}

- (void)setupPendingPropertiesForViewStateSignIn
{
    self.logoImg.pendingAlpha           = 1.0f;
    self.logoImg.pendingY               = 78;

    self.usernameTxtfld.pendingAlpha    = 0.5f;
    [self.usernameTxtfld applyPendingAlpha];
    [self.resetUsernameTxtfld applyPendingAlpha];

    self.usernameTxtfld.pendingOrigin       = (CGPoint){ 20, 196 };
    self.resetUsernameTxtfld.pendingOrigin  = (CGPoint){ 20, 196 };

    self.passwordTxtfld.pendingAlpha    = 0.5f;
    self.passwordTxtfld.pendingOrigin   = (CGPoint){ 20, 258 };

    self.signInBtn.pendingAlpha         = 1.0f;
    self.signInBtn.pendingY             = 324;

    self.forgotPasswordBtn.pendingAlpha = 1.0f;
    self.forgotPasswordBtn.pendingY     = 510;

    self.signUpBtn.pendingTransform         = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    self.forgotPasswordBtn.pendingTransform = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);

    self.signInBtn.pendingTransform         = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
    self.cancelResetBtn.pendingTransform    = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    self.passwordTxtfld.pendingTransform    = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
    self.resetPasswordBtn.pendingTransform  = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    if ([DNUtilities isTall] == NO)
    {
        self.usernameTxtfld.pendingY        = self.usernameTxtfld.pendingY - 40;
        self.passwordTxtfld.pendingY        = self.passwordTxtfld.pendingY - 40;

        self.signInBtn.pendingY             = self.signInBtn.pendingY - 40;
        self.forgotPasswordBtn.pendingY     = self.forgotPasswordBtn.pendingY - 40;
    }
}

- (void)setupPendingPropertiesForViewStateSignInValid
{
    self.signInBtn.enabled = YES;

    [self setupPendingPropertiesForViewStateSignIn];
}

- (void)setupPendingPropertiesForViewStateSignInKeyboard
{
    self.usernameTxtfld.pendingAlpha    = ([self.signInForm formFieldForFirstResponder].userView == self.usernameTxtfld) ? 1.0f : 0.5f;
    self.passwordTxtfld.pendingAlpha    = ([self.signInForm formFieldForFirstResponder].userView == self.passwordTxtfld) ? 1.0f : 0.5f;
    self.signInBtn.pendingAlpha         = 1.0f;
    self.forgotPasswordBtn.pendingAlpha = 1.0f;

    self.logoImg.pendingY           = -60;
    self.usernameTxtfld.pendingY    = 77;
    self.passwordTxtfld.pendingY    = 139;
    self.signInBtn.pendingY         = 210;
    self.forgotPasswordBtn.pendingY = 270;

    self.signUpBtn.pendingTransform         = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    self.forgotPasswordBtn.pendingTransform = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);

    self.signInBtn.pendingTransform         = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
    self.cancelResetBtn.pendingTransform    = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    self.passwordTxtfld.pendingTransform    = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
    self.resetPasswordBtn.pendingTransform  = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    if ([DNUtilities isDeviceIPad] == YES)
    {
        self.logoImg.pendingAlpha   = 1.0f;

        if (UIInterfaceOrientationIsLandscape([UIApplication currentOrientation]))
        {
            self.logoImg.pendingY           = -41;
            self.usernameTxtfld.pendingY    = 37;
            self.passwordTxtfld.pendingY    = 99;
            self.signInBtn.pendingY         = 170;
            self.forgotPasswordBtn.pendingY = 230;
        }
    }
    else if ([DNUtilities isTall] == NO)
    {
        self.passwordTxtfld.pendingY    = self.passwordTxtfld.pendingY - 4;
        self.signInBtn.pendingY         = self.signInBtn.pendingY - 18;
        self.forgotPasswordBtn.pendingY = self.forgotPasswordBtn.pendingY - 26;
    }
}

- (void)setupPendingPropertiesForViewStateSignInKeyboardValid
{
    [self setupPendingPropertiesForViewStateSignInKeyboard];
}

- (void)setupPendingPropertiesForViewStateSignInProcessing
{
    self.usernameTxtfld.pendingAlpha    = 0.25f;
    self.passwordTxtfld.pendingAlpha    = 0.25f;

    self.signUpBtn.pendingTransform         = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    self.forgotPasswordBtn.pendingTransform = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);

    self.signInBtn.pendingTransform         = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
    self.cancelResetBtn.pendingTransform    = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    self.passwordTxtfld.pendingTransform    = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
    self.resetPasswordBtn.pendingTransform  = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);

    self.disabledView.pendingAlpha          = 0.6f;
    self.disabledSpinnerImg.pendingAlpha    = 1.0f;
}

- (void)setupPendingPropertiesForErrorBanner
{
    self.signInBtn.enabled = NO;

    CGFloat errorLabelWidth     = self.errorBannerLabel.frame.size.width;
    CGSize  constraint          = CGSizeMake(errorLabelWidth - 12.0f, CGFLOAT_MAX);
    CGRect  errorSizeFrame      = [self.errorBannerLabel.attributedText boundingRectWithSize:constraint
                                                                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                                     context:nil];
    CGFloat errorLabelHeight    = errorSizeFrame.size.height;

    if (errorLabelHeight > 24)
    {
        self.logoImg.pendingY   = self.logoImg.frame.origin.y - (errorLabelHeight - 24);
    }

    self.errorBanner.frame          = (CGRect){ 20, 210 - errorLabelHeight, errorLabelWidth, errorLabelHeight + 18 };
    self.errorBannerNipple.origin   = (CGPoint){ 12, errorLabelHeight + 5 };

    self.errorBanner.pendingFrame           = (CGRect){ 20, 175 - errorLabelHeight, errorLabelWidth, errorLabelHeight + 18 };
    self.errorBannerBubbleView.pendingSize  = (CGSize){ errorLabelWidth, errorLabelHeight + 12 };
    self.errorBannerLabel.pendingSize       = (CGSize){ errorLabelWidth, errorLabelHeight };
    self.errorBannerNipple.pendingY         = errorLabelHeight + 12;

    self.errorBanner.pendingAlpha           = 1.0f;
    self.errorBannerBubbleView.pendingAlpha = 1.0f;
    self.errorBannerLabel.pendingAlpha      = 1.0f;
    self.errorBannerNipple.pendingAlpha     = 1.0f;

    self.usernameTxtfld.pendingAlpha        = 0.5f;
    self.passwordTxtfld.pendingAlpha        = 0.5f;

    if ([DNUtilities isTall] == NO)
    {
        self.logoImg.pendingAlpha   = 0.0f;
        self.errorBanner.pendingY   = self.errorBanner.pendingY - 40;
    }
}

- (void)setupPendingPropertiesForViewStateSignInError
{
    [self setupPendingPropertiesForViewStateSignIn];
    [self setupPendingPropertiesForErrorBanner];
}

- (void)setupPendingPropertiesForViewStateSignInSuccess
{
    [self setupPendingPropertiesForViewStateSignInProcessing];
}

- (void)setupPendingPropertiesForViewStateResetPassword
{
    self.logoImg.pendingAlpha           = 1.0f;

    self.resetUsernameTxtfld.pendingAlpha    = 0.5f;
    [self.resetUsernameTxtfld applyPendingAlpha];
    [self.usernameTxtfld applyPendingAlpha];

    self.resetUsernameTxtfld.pendingOrigin   = (CGPoint){ 20, 196 };

    self.resetPasswordBtn.pendingAlpha  = 1.0f;
    self.cancelResetBtn.pendingAlpha    = 1.0f;

    self.logoImg.pendingY               = 78;

    self.resetPasswordBtn.pendingY      = 258;
    self.cancelResetBtn.pendingY        = 510;  // 324;

    self.signInBtn.pendingTransform         = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    self.cancelResetBtn.pendingTransform    = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);

    self.passwordTxtfld.pendingTransform    = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    self.resetPasswordBtn.pendingTransform  = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
}

- (void)setupPendingPropertiesForViewStateResetPasswordValid
{
    [self setupPendingPropertiesForViewStateResetPassword];
}

- (void)setupPendingPropertiesForViewStateResetPasswordKeyboard
{
    self.logoImg.pendingAlpha           = 1.0f;

    self.resetUsernameTxtfld.pendingAlpha   = ([self.resetPasswordForm formFieldForFirstResponder].userView == self.resetUsernameTxtfld) ? 1.0f : 0.5f;

    self.resetPasswordBtn.pendingAlpha      = 1.0f;
    self.cancelResetBtn.pendingAlpha        = 1.0f;

    self.logoImg.pendingY               = 58;
    self.resetUsernameTxtfld.pendingY   = 148;
    self.resetPasswordBtn.pendingY      = 210;
    self.cancelResetBtn.pendingY        = 270;

    self.signInBtn.pendingTransform         = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    self.cancelResetBtn.pendingTransform    = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);

    self.passwordTxtfld.pendingTransform    = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    self.resetPasswordBtn.pendingTransform  = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);

    if ([DNUtilities isDeviceIPad] == YES)
    {
        if (UIInterfaceOrientationIsLandscape([UIApplication currentOrientation]))
        {
            self.logoImg.pendingY               = 0;
            self.resetUsernameTxtfld.pendingY   = 108;
            self.resetPasswordBtn.pendingY      = 170;
            self.cancelResetBtn.pendingY        = 230;
        }
    }
    else if ([DNUtilities isTall] == NO)
    {
        self.logoImg.pendingAlpha           = 0.0f;
        self.resetUsernameTxtfld.pendingY   = self.resetUsernameTxtfld.pendingY - 40;
        self.resetPasswordBtn.pendingY      = self.resetPasswordBtn.pendingY - 40;
        self.cancelResetBtn.pendingY        = self.cancelResetBtn.pendingY - 40;
    }
}

- (void)setupPendingPropertiesForViewStateResetPasswordKeyboardValid
{
    [self setupPendingPropertiesForViewStateResetPasswordKeyboard];
}

- (void)setupPendingPropertiesForViewStateResetPasswordProcessing
{
    [self setupPendingPropertiesForViewStateResetPassword];

    self.resetUsernameTxtfld.pendingAlpha   = 0.25f;

    self.disabledView.pendingAlpha          = 0.6f;
    self.disabledSpinnerImg.pendingAlpha    = 1.0f;
}

- (void)setupPendingPropertiesForViewStateResetPasswordError
{
    [self setupPendingPropertiesForErrorBanner];

    self.signInBtn.enabled = NO;

    self.logoImg.pendingAlpha           = 1.0f;
    self.passwordTxtfld.pendingAlpha    = 0.0f;
    self.resetPasswordBtn.pendingAlpha  = 1.0f;
    self.cancelResetBtn.pendingAlpha    = 1.0f;

    self.signInBtn.pendingTransform         = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    self.cancelResetBtn.pendingTransform    = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);

    self.passwordTxtfld.pendingTransform    = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    self.resetPasswordBtn.pendingTransform  = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);

    if ([DNUtilities isTall] == NO)
    {
        self.errorBanner.pendingY   = self.errorBanner.pendingY + 40;
    }
}

- (void)setupPendingPropertiesForViewStateResetPasswordSuccess
{
    [self setupPendingPropertiesForViewStateSignInError];

    self.signInBtn.enabled = YES;
}

#pragma mark - ViewState Transitions

- (void)changeToViewState:(NSString*)newViewState
                 animated:(BOOL)animated
               completion:(void(^)(BOOL finished))completion
{
    [super changeToViewState:newViewState
                    animated:animated
                  completion:^(BOOL finished)
     {
         [self updateViewsForFormValidity];
         if (completion != nil)
         {
             completion(finished);
         }
     }];
}

- (double)transitionDurationToViewStateWelcome
{
    return 1.3f;
}

- (void)transitionToViewStateWelcome:(DNStateOptions*)options
{
    double  duration    = options.toDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:1.3f / duration
                                  animations:^
     {
         [self.contentView applyPendingFrame];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.5f / duration
                            relativeDuration:0.5f / duration
                                  animations:^
     {
         [self.signInBtn applyPendingAlpha];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.65f / duration
                            relativeDuration:0.5f / duration
                                  animations:^
     {
         [self.signUpBtn applyPendingAlpha];
     }];
}

- (void)transitionFromViewStateWelcomeToSignIn:(DNStateOptions*)options
{
    double  duration    = options.duration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.0f / duration
                                  animations:^
     {
         [self.usernameTxtfld applyPendingAlpha];
         [self.passwordTxtfld applyPendingAlpha];
     }];
    
    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.8f / duration
                                  animations:^
     {
         [self.logoImg applyPendingAlpha];

         [self.logoImg applyPendingFrame];
         [self.signInBtn applyPendingFrame];
         [self.forgotPasswordBtn applyPendingFrame];
         [self.usernameTxtfld applyPendingFrame];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.1f / duration
                            relativeDuration:0.8f / duration
                                  animations:^
     {
         [self.passwordTxtfld applyPendingFrame];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:1.0f / duration
                                  animations:^
     {
         [self.signUpBtn applyPendingTransform];

         [self.forgotPasswordBtn applyPendingTransform];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.5f / duration
                            relativeDuration:0.0f / duration
                                  animations:^
     {
         [self.signUpBtn applyPendingAlpha];

         [self.forgotPasswordBtn applyPendingAlpha];
     }];
}

- (double)transitionDurationToViewStateSignInKeyboard
{
    return 0.4f;
}

- (void)transitionToViewStateSignInKeyboard:(DNStateOptions*)options
{
    double  duration    = options.toDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.4f / duration
                                  animations:^
     {
         [self.logoImg applyPendingAlpha];

         [self.logoImg applyPendingFrame];
         [self.resetUsernameTxtfld applyPendingFrame];
         [self.passwordTxtfld applyPendingFrame];
         [self.signInBtn applyPendingFrame];
         [self.forgotPasswordBtn applyPendingFrame];
     }];
}

- (double)transitionDurationFromViewStateSignInError
{
    return 0.4f;
}

- (void)transitionFromViewStateSignInError:(DNStateOptions*)options
{
    double  duration    = options.fromDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.4f / duration
                                  animations:^
     {
         [self.errorBanner applyPendingFrame];

         [self.errorBanner applyPendingAlpha];
         [self.errorBannerLabel applyPendingAlpha];
         [self.errorBannerNipple applyPendingAlpha];
     }];
}

- (double)transitionDurationToViewStateSignInError
{
    return 0.6f;
}

- (void)transitionToViewStateSignInError:(DNStateOptions*)options
{
    double  duration    = options.toDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.0f / duration
                                  animations:^
     {
         [self.errorBannerLabel applyPendingFrame];
         [self.errorBannerBubbleView applyPendingFrame];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.4f / duration
                                  animations:^
     {
         [self.errorBanner applyPendingFrame];

         [self.errorBanner applyPendingAlpha];
         [self.errorBannerBubbleView applyPendingAlpha];
         [self.errorBannerLabel applyPendingAlpha];
         [self.errorBannerNipple applyPendingAlpha];

         [self.usernameTxtfld applyPendingAlpha];
         [self.passwordTxtfld applyPendingAlpha];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.4f / duration
                            relativeDuration:0.2f / duration
                                  animations:^
     {
         [self.errorBannerNipple applyPendingFrame];
     }];
}

- (double)transitionDurationToViewStateSignInValid
{
    return [self transitionDurationToViewStateSignIn];
}

- (void)transitionToViewStateSignInValid:(DNStateOptions*)options
{
    [self transitionToViewStateSignIn:options];
}

- (double)transitionDurationToViewStateSignIn
{
    return 0.4f;
}

- (void)transitionToViewStateSignIn:(DNStateOptions*)options
{
    double  duration    = options.toDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.4f / duration
                                  animations:^
     {
         [self.logoImg applyPendingAlpha];

         [self.logoImg applyPendingFrame];
         [self.usernameTxtfld applyPendingFrame];
         [self.passwordTxtfld applyPendingFrame];
         [self.signInBtn applyPendingFrame];
         [self.forgotPasswordBtn applyPendingFrame];
     }];
}

- (double)transitionDurationToViewStateSignInProcessing
{
    return 0.3f;
}

- (void)transitionToViewStateSignInProcessing:(DNStateOptions*)options
{
    double  duration    = options.toDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.3f / duration
                                  animations:^
     {
         [self.usernameTxtfld applyPendingAlpha];
         [self.passwordTxtfld applyPendingAlpha];

         [self.disabledView applyPendingAlpha];
         [self.disabledSpinnerImg applyPendingAlpha];
     }];

    [self spinWithOptions:UIViewAnimationOptionCurveEaseIn];

    [self setupPendingPropertiesForViewStateSignIn];
    [self transitionToViewStateSignIn:options];
}

- (double)transitionDurationFromViewStateSignInProcessing
{
    return 0.3f;
}

- (void)transitionFromViewStateSignInProcessing:(DNStateOptions*)options
{
    double  duration    = options.fromDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.3f / duration
                                  animations:^
     {
         [self.usernameTxtfld applyPendingAlpha];
         [self.passwordTxtfld applyPendingAlpha];

         [self.disabledView applyPendingAlpha];
     }];
}

- (double)transitionDurationToViewStateSignInSuccess
{
    return [self transitionDurationToViewStateSignInProcessing];
}

- (void)transitionToViewStateSignInSuccess:(DNStateOptions*)options
{
    [self transitionToViewStateSignInProcessing:options];
}

- (double)transitionDurationFromViewStateSignInSuccess
{
    return [self transitionDurationFromViewStateSignInProcessing];
}

- (void)transitionFromViewStateSignInSuccess:(DNStateOptions*)options
{
    [self transitionFromViewStateSignInProcessing:options];
}

- (double)transitionDurationToViewStateResetPassword
{
    return 0.4f;
}

- (void)transitionToViewStateResetPassword:(DNStateOptions*)options
{
    double  duration    = options.toDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.4f / duration
                                  animations:^
     {
         [self.logoImg applyPendingFrame];

         [self.resetUsernameTxtfld applyPendingFrame];
         [self.resetPasswordBtn applyPendingFrame];
         [self.cancelResetBtn applyPendingFrame];
     }];
}

- (void)transitionFromViewStateSignInKeyboardValidToResetPasswordKeyboardValid:(DNStateOptions*)options
{
    [self transitionFromViewStateSignInToResetPassword:options];
}

- (void)transitionFromViewStateSignInKeyboardToResetPasswordKeyboard:(DNStateOptions*)options
{
    [self transitionFromViewStateSignInToResetPassword:options];
}

- (void)transitionFromViewStateSignInToResetPassword:(DNStateOptions*)options
{
    double  duration    = options.duration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.0f / duration
                                  animations:^
     {
         [self.resetPasswordBtn applyPendingFrame];
         [self.cancelResetBtn applyPendingFrame];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.8f / duration
                                  animations:^
     {
         [self.logoImg applyPendingAlpha];

         [self.logoImg applyPendingFrame];
         [self.resetUsernameTxtfld applyPendingFrame];
         [self.passwordTxtfld applyPendingFrame];

         [self.forgotPasswordBtn applyPendingAlpha];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:1.0f / duration
                                  animations:^
     {
         [self.signInBtn applyPendingTransform];
         [self.cancelResetBtn applyPendingTransform];

         [self.passwordTxtfld applyPendingTransform];
         [self.resetPasswordBtn applyPendingTransform];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.5f / duration
                            relativeDuration:0.01f / duration
                                  animations:^
     {
         [self.signInBtn applyPendingAlpha];
         [self.cancelResetBtn applyPendingAlpha];

         [self.passwordTxtfld applyPendingAlpha];
         [self.resetPasswordBtn applyPendingAlpha];
     }];
}

- (void)transitionFromViewStateResetPasswordProcessingToSignIn:(DNStateOptions*)options
{
    [self transitionFromViewStateResetPasswordToSignIn:options];
}

- (void)transitionFromViewStateResetPasswordKeyboardToSignInKeyboard:(DNStateOptions*)options
{
    [self transitionFromViewStateResetPasswordToSignIn:options];
}

- (void)transitionFromViewStateResetPasswordKeyboardValidToSignInKeyboardValid:(DNStateOptions*)options
{
    [self transitionFromViewStateResetPasswordToSignIn:options];
}

- (void)transitionFromViewStateResetPasswordToSignIn:(DNStateOptions*)options
{
    double  duration    = options.duration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.0f / duration
                                  animations:^
     {
         [self.signInBtn applyPendingFrame];
         [self.forgotPasswordBtn applyPendingFrame];

         [self.resetPasswordBtn applyPendingFrame];
         [self.cancelResetBtn applyPendingFrame];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.2f / duration
                            relativeDuration:0.8f / duration
                                  animations:^
     {
         [self.logoImg applyPendingAlpha];

         [self.logoImg applyPendingFrame];
         [self.usernameTxtfld applyPendingFrame];
         [self.passwordTxtfld applyPendingFrame];
         [self.resetUsernameTxtfld applyPendingFrame];

         [self.forgotPasswordBtn applyPendingAlpha];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:1.0f / duration
                                  animations:^
     {
         [self.signInBtn applyPendingTransform];
         [self.cancelResetBtn applyPendingTransform];

         [self.passwordTxtfld applyPendingTransform];
         [self.resetPasswordBtn applyPendingTransform];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.5f / duration
                            relativeDuration:0.01f / duration
                                  animations:^
     {
         [self.signInBtn applyPendingAlpha];
         [self.cancelResetBtn applyPendingAlpha];

         [self.passwordTxtfld applyPendingAlpha];
         [self.resetPasswordBtn applyPendingAlpha];
     }];
}

- (void)transitionFromViewStateResetPasswordKeyboard:(DNStateOptions*)options
{
    [self transitionToViewStateResetPasswordKeyboard:options];
}

- (double)transitionDurationToViewStateResetPasswordKeyboard
{
    return 0.4f;
}

- (void)transitionToViewStateResetPasswordKeyboard:(DNStateOptions*)options
{
    double  duration    = options.toDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.4f / duration
                                  animations:^
     {
         [self.logoImg applyPendingAlpha];

         [self.logoImg applyPendingFrame];
         [self.resetUsernameTxtfld applyPendingFrame];
         [self.resetPasswordBtn applyPendingFrame];
         [self.cancelResetBtn applyPendingFrame];
     }];
}

- (double)transitionDurationToViewStateResetPasswordProcessing
{
    return 0.3f;
}

- (void)transitionToViewStateResetPasswordProcessing:(DNStateOptions*)options
{
    double  duration    = options.toDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.3f / duration
                                  animations:^
     {
         [self.resetUsernameTxtfld applyPendingAlpha];

         [self.disabledView applyPendingAlpha];
         [self.disabledSpinnerImg applyPendingAlpha];
     }];

    [self spinWithOptions:UIViewAnimationOptionCurveEaseIn];

    [self setupPendingPropertiesForViewStateResetPassword];
    [self transitionToViewStateResetPassword:options];
}

- (double)transitionDurationFromViewStateResetPasswordProcessing
{
    return 0.3f;
}

- (void)transitionFromViewStateResetPasswordProcessing:(DNStateOptions*)options
{
    double  duration    = options.fromDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.3f / duration
                                  animations:^
     {
         [self.disabledView applyPendingAlpha];
         [self.disabledSpinnerImg applyPendingAlpha];
     }];
}

- (double)transitionDurationFromViewStateResetPasswordError
{
    return 0.4f;
}

- (void)transitionFromViewStateResetPasswordError:(DNStateOptions*)options
{
    double  duration    = options.fromDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.4f / duration
                                  animations:^
     {
         [self.errorBanner applyPendingFrame];

         [self.errorBanner applyPendingAlpha];
         [self.errorBannerLabel applyPendingAlpha];
         [self.errorBannerNipple applyPendingAlpha];
     }];
}

- (double)transitionDurationToViewStateResetPasswordError
{
    return 0.6f;
}

- (void)transitionToViewStateResetPasswordError:(DNStateOptions*)options
{
    double  duration    = options.toDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.0f / duration
                                  animations:^
     {
         [self.errorBannerLabel applyPendingFrame];
         [self.errorBannerBubbleView applyPendingFrame];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.4f / duration
                                  animations:^
     {
         [self.errorBanner applyPendingFrame];

         [self.errorBanner applyPendingAlpha];
         [self.errorBannerBubbleView applyPendingAlpha];
         [self.errorBannerLabel applyPendingAlpha];
         [self.errorBannerNipple applyPendingAlpha];

         [self.resetUsernameTxtfld applyPendingAlpha];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.4f / duration
                            relativeDuration:0.2f / duration
                                  animations:^
     {
         [self.errorBannerNipple applyPendingFrame];
     }];
}

- (void)transitionToViewStateResetPasswordSuccess:(DNStateOptions*)options
{
    [self transitionFromViewStateResetPasswordToSignIn:options];
}

- (double)transitionDurationFromViewStateResetPasswordSuccess
{
    return 0.3f;
}

- (void)transitionFromViewStateResetPasswordSuccess:(DNStateOptions*)options
{
    double  duration    = options.fromDuration;

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.0f / duration
                                  animations:^
     {
         [self.errorBannerNipple applyPendingAlpha];
     }];

    [UIView addKeyframeWithRelativeStartTime:0.0f / duration
                            relativeDuration:0.3f / duration
                                  animations:^
     {
         [self.errorBanner applyPendingAlpha];
         [self.errorBannerBubbleView applyPendingAlpha];
         [self.errorBannerLabel applyPendingAlpha];
         [self.errorBannerNipple applyPendingAlpha];
     }];
}

#pragma mark - EZForm initialization & update methods

- (void)initializeSignInForm
{
    // Create EZForm instance to manage the form.
    self.signInForm = [[EZForm alloc] init];
    self.signInForm.inputAccessoryType = EZFormInputAccessoryTypeStandard;
    self.signInForm.delegate = self;

    [self.signInForm setInputAccessoryViewBarTintColor:[UIColor whiteColor]];
    [self.signInForm setInputAccessoryViewTintColor:[UIColor blueColor]];
    [self.signInForm setInputAccessoryViewTranslucent:YES];

    /* Add an EZFormTextField instance to handle the username field.
     * Enables a validation rule of 1 character minimum.
     * Limits the input text field to 32 characters maximum (when hooked up to a control).
     */
    EZFormTextField*    usernameField = [[EZFormTextField alloc] initWithKey:EZLOGWelcomeViewUsernameKey];
    usernameField.inputMaxCharacters = 128;
    [usernameField addValidator:EZFormEmailAddressValidator];
    [usernameField addInputFilter:EZFormEmailAddressInputFilter];
    [self.signInForm addFormField:usernameField];

    /* Add an EZFormTextField instance to handle the password field.
     * Enables a validation rule of 3 character minimum.
     * Limits the input text field to 32 characters maximum (when hooked up to a control).
     */
    EZFormTextField*    passwordField = [[EZFormTextField alloc] initWithKey:EZLOGWelcomeViewPasswordKey];
    passwordField.validationMinCharacters   = 1;
    passwordField.inputMaxCharacters        = 128;
    [self.signInForm addFormField:passwordField];
}

- (void)initializeResetPasswordForm
{
    // Create EZForm instance to manage the form.
    self.resetPasswordForm = [[EZForm alloc] init];
    self.resetPasswordForm.inputAccessoryType = EZFormInputAccessoryTypeStandard;
    self.resetPasswordForm.delegate = self;

    [self.resetPasswordForm setInputAccessoryViewBarTintColor:[UIColor whiteColor]];
    [self.resetPasswordForm setInputAccessoryViewTintColor:[UIColor blueColor]];
    [self.resetPasswordForm setInputAccessoryViewTranslucent:YES];

    /* Add an EZFormTextField instance to handle the username field.
     * Enables a validation rule of 1 character minimum.
     * Limits the input text field to 32 characters maximum (when hooked up to a control).
     */
    EZFormTextField*    resetUsernameField = [[EZFormTextField alloc] initWithKey:EZLOGWelcomeViewResetUsernameKey];
    resetUsernameField.inputMaxCharacters = 128;
    [resetUsernameField addValidator:EZFormEmailAddressValidator];
    [resetUsernameField addInputFilter:EZFormEmailAddressInputFilter];
    [self.resetPasswordForm addFormField:resetUsernameField];
}

- (void)updateViewsForFormValidity
{
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignIn] == YES)
    {
        self.signInBtn.enabled = [self.signInForm isFormValid];
        if (self.signInBtn.enabled)
        {
            [self changeToViewState:LOGWelcomeViewViewStateSignInValid animated:YES completion:nil];
        }
        return;
    }

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInKeyboard] == YES)
    {
        self.signInBtn.enabled = [self.signInForm isFormValid];
        if (self.signInBtn.enabled)
        {
            [self changeToViewState:LOGWelcomeViewViewStateSignInKeyboardValid animated:YES completion:nil];
        }
        return;
    }

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInKeyboardValid] == YES)
    {
        self.signInBtn.enabled = [self.signInForm isFormValid];
        if (!self.signInBtn.enabled)
        {
            [self changeToViewState:LOGWelcomeViewViewStateSignInKeyboard animated:YES completion:nil];
        }
        return;
    }

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPassword] == YES)
    {
        self.resetPasswordBtn.enabled = [self.resetPasswordForm isFormValid];
        if (self.resetPasswordBtn.enabled)
        {
            [self changeToViewState:LOGWelcomeViewViewStateResetPasswordValid animated:YES completion:nil];
        }
        return;
    }

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordKeyboard] == YES)
    {
        self.resetPasswordBtn.enabled = [self.resetPasswordForm isFormValid];
        if (self.resetPasswordBtn.enabled)
        {
            [self changeToViewState:LOGWelcomeViewViewStateResetPasswordKeyboardValid animated:YES completion:nil];
        }
        return;
    }

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordKeyboardValid] == YES)
    {
        self.resetPasswordBtn.enabled = [self.resetPasswordForm isFormValid];
        if (!self.resetPasswordBtn.enabled)
        {
            [self changeToViewState:LOGWelcomeViewViewStateResetPasswordKeyboard animated:YES completion:nil];
        }
        return;
    }
}

#pragma mark - EZFormDelegate methods

- (void)formInputAccessoryViewDone:(EZForm *)form
{
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInKeyboard] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateSignIn animated:YES completion:nil];
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInKeyboardValid] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateSignInValid animated:YES completion:nil];
    }

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordKeyboard] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateResetPassword animated:YES completion:nil];
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordKeyboardValid] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateResetPasswordValid animated:YES completion:nil];
    }
}

- (void)form:(EZForm*)form fieldDidBeginEditing:(EZFormField*)formField
{
    NSString*   newState;

    if (([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInError] == YES) ||
        ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordSuccess] == YES) ||
        ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignIn] == YES) ||
        ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInValid] == YES))
    {
        newState    = LOGWelcomeViewViewStateSignInKeyboard;
    }

    if (([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordError] == YES) ||
        ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPassword] == YES) ||
        ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordValid] == YES))
    {
        newState    = LOGWelcomeViewViewStateResetPasswordKeyboard;
    }

    formClosingFlag = NO;

    if (newState)
    {
        [self changeToViewState:newState animated:YES completion:nil];
    }

    formField.userView.pendingAlpha   = 1.0f;

    [UIView animateWithDuration:0.3f
                     animations:^
     {
         [formField.userView applyPendingAlpha];
     }];
}

- (NSString*)fieldDidEndEditingStateChange
{
    NSString*   newState = nil;

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInKeyboard] == YES)
    {
        newState    = LOGWelcomeViewViewStateSignIn;
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInKeyboardValid] == YES)
    {
        newState    = LOGWelcomeViewViewStateSignInValid;
    }

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordKeyboard] == YES)
    {
        newState    = LOGWelcomeViewViewStateResetPassword;
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordKeyboardValid] == YES)
    {
        newState    = LOGWelcomeViewViewStateResetPasswordValid;
    }

    return newState;
}

- (void)form:(EZForm *)form fieldDidEndEditing:(EZFormField *)formField
{
    if ([self fieldDidEndEditingStateChange])
    {
        formClosingFlag = YES;

        [DNUtilities runAfterDelay:1.0f
                             block:^
         {
             if (formClosingFlag && !self.transitionPending)
             {
                 formClosingFlag    = NO;

                 NSString*  newState = [self fieldDidEndEditingStateChange];
                 if (newState)
                 {
                     [self changeToViewState:newState animated:YES completion:nil];
                 }
             }
         }];
    }

    formField.userView.pendingAlpha   = 0.5f;

    [UIView animateWithDuration:0.3f
                     animations:^
     {
         [formField.userView applyPendingAlpha];
     }];
}

- (void)form:(EZForm*)form didUpdateValueForField:(EZFormField*)formField modelIsValid:(BOOL)isValid
{
#pragma unused(formField, isValid)
    if (form == self.signInForm)
    {
    }

    if (form == self.resetPasswordForm)
    {
    }

    [self updateViewsForFormValidity];
}

- (void)formInputFinishedOnLastField:(EZForm*)form
{
    if (form == self.signInForm)
    {
        if ([form isFormValid])
        {
            [self signInAction:nil];
        }
    }

    if (form == self.resetPasswordForm)
    {
        if ([form isFormValid])
        {
            [self resetPasswordAction:nil];
        }
    }
}

#pragma mark - Button Actions

- (IBAction)signInAction:(id)sender
{
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateWelcome] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateSignIn animated:YES completion:nil];
        return;
    }

    if (([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInKeyboardValid] == YES) ||
        ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInValid] == YES))
    {
        [self.signInForm resignFirstResponder];
        [self.usernameTxtfld dismissSuggestionView];

        [self changeToViewState:LOGWelcomeViewViewStateSignInProcessing animated:YES completion:nil];

        // Perform Login
        if (1)
        {
            // If Login Successful...
            [self changeToViewState:LOGWelcomeViewViewStateSignInSuccess animated:YES completion:nil];

            [DNUtilities runAfterDelay:2.0f
                                 block:^
             {
                 [self dismissViewControllerAnimated:YES
                                          completion:^
                  {
                      self.loginBlock(self);
                  }];
             }];
        }
        else
        {
            // If Login Failed...
            [DNUtilities runAfterDelay:5.0f
                                 block:^
             {
                 self.errorBannerLabel.text = @"Login Failed";
                 [self changeToViewState:LOGWelcomeViewViewStateSignInError animated:YES completion:nil];
             }];
        }
    }
}

- (IBAction)signUpAction:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:^
     {
         self.loginBlock(self);
     }];
}

- (IBAction)resetPasswordAction:(id)sender
{
    if (([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordKeyboardValid] == YES) ||
        ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordValid] == YES))
    {
        [[self.signInForm formFieldForKey:EZLOGWelcomeViewUsernameKey] setFieldValue:self.resetUsernameTxtfld.text];

        [self.resetPasswordForm resignFirstResponder];
        [self.resetUsernameTxtfld dismissSuggestionView];

        [self changeToViewState:LOGWelcomeViewViewStateResetPasswordProcessing animated:YES completion:nil];

        // Perform ResetPassword
        if (1)
        {
            // If ResetPassword Successful...
            [self changeToViewState:LOGWelcomeViewViewStateSignInSuccess animated:YES completion:nil];

            [DNUtilities runAfterDelay:2.0f
                                 block:^
             {
                 self.errorBannerLabel.text = @"You will receive an email in a few moments with instructions for how to reset your password.";
                 [self changeToViewState:LOGWelcomeViewViewStateResetPasswordSuccess animated:YES completion:nil];
             }];
        }
        else
        {
            // If ResetPassword Failed...
            [DNUtilities runAfterDelay:5.0f
                                 block:^
             {
                 self.errorBannerLabel.text = @"ResetPassword Failed";
                 [self changeToViewState:LOGWelcomeViewViewStateResetPasswordError animated:YES completion:nil];
             }];
        }
    }
}

- (void)setForm:(EZForm*)form
 firstResponder:(UIView*)firstResponder
{
    [firstResponder becomeFirstResponder];
    [form scrollFormFieldToVisible:[self.resetPasswordForm formFieldForKey:EZLOGWelcomeViewUsernameKey]];
}

- (IBAction)forgotPasswordAction:(id)sender
{
    [[self.resetPasswordForm formFieldForKey:EZLOGWelcomeViewResetUsernameKey] setFieldValue:self.usernameTxtfld.text];

    [self.signInForm resignFirstResponder];

    [self.resetUsernameTxtfld dismissSuggestionView];

    EZFormField*    formField   = [self.resetPasswordForm formFieldForFirstResponder];
    if (formField && (formField.userView != self.resetUsernameTxtfld))
    {
        [self setForm:self.resetPasswordForm firstResponder:self.resetUsernameTxtfld];
    }

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInKeyboard] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateResetPasswordKeyboard animated:YES completion:nil];
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInKeyboardValid] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateResetPasswordKeyboardValid animated:YES completion:nil];
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignIn] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateResetPassword animated:YES completion:nil];
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateSignInValid] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateResetPasswordValid animated:YES completion:nil];
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordSuccess] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateResetPasswordValid animated:YES completion:nil];
    }
}

- (IBAction)cancelResetAction:(id)sender
{
    [[self.signInForm formFieldForKey:EZLOGWelcomeViewUsernameKey] setFieldValue:self.resetUsernameTxtfld.text];

    [self.usernameTxtfld dismissSuggestionView];

    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordKeyboard] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateSignInKeyboard animated:YES completion:nil];
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordKeyboardValid] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateSignInKeyboardValid animated:YES completion:nil];
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPassword] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateSignIn animated:YES completion:nil];
    }
    if ([self.currentViewState isEqualToString:LOGWelcomeViewViewStateResetPasswordValid] == YES)
    {
        [self changeToViewState:LOGWelcomeViewViewStateSignInValid animated:YES completion:nil];
    }
}

#pragma mark - Utility methods

- (void)spinWithOptions:(UIViewAnimationOptions)options
{
    // this spin completes 360 degrees every 2 seconds
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:options
                     animations:^
     {
         self.disabledSpinnerImg.transform = CGAffineTransformRotate(self.disabledSpinnerImg.transform, M_PI / 2);
     }
                     completion:^(BOOL finished)
     {
         if (self.disabledView.alpha > 0.0f)
         {
             // if flag still set, keep spinning with constant speed
             [self spinWithOptions: UIViewAnimationOptionCurveLinear];
         }
         else if (options != UIViewAnimationOptionCurveEaseOut)
         {
             // one last spin, with deceleration
             [self spinWithOptions: UIViewAnimationOptionCurveEaseOut];
         }
     }];
}

@end
