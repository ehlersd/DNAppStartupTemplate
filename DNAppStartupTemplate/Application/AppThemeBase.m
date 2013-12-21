//
//  AppThemeBase.h
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#import "AppThemeBase.h"

#import "UIColor-Expanded.h"
#import "UIFont+Custom.h"

@implementation AppThemeBase

// - (NSString*)LOGWelcomeViewNibName  {   return @"LOGWelcomeViewController"; }

//
// Label Defaults
//
- (UIFont*)LabelFont                {   return [UIFont customFontWithName:@"ProximaNova-Regular" size:12.0f];   }

- (UIColor*)LabelColor              {   return [UIColor whiteColor];    }

- (NSNumber*)LabelKerning           {   return @1.0f;   }

- (NSNumber*)LabelHorizontalPadding {   return @6.0f;   }
- (NSNumber*)LabelVerticalPadding   {   return @0.0f;   }

//
// Button Defaults
//
- (UIFont*)ButtonLabelFont          {   return [UIFont customFontWithName:@"ProximaNova-Regular" size:18.0f];   }

- (UIColor*)ButtonLabelColor        {   return [UIColor whiteColor];    }

- (NSNumber*)ButtonLabelKerning     {   return @2.5f;   }

- (UIColor*)ButtonBackgroundColor   {   return [UIColor clearColor];    }

- (UIColor*)ButtonBorderColor       {   return [UIColor whiteColor];    }

- (NSNumber*)ButtonBorderWidth      {   return @1.0f;    }

- (UIColor*)LOGWelcomeViewForgotPasswordButtonLabelColor    {   return [UIColor blackColor];  }
- (NSNumber*)LOGWelcomeViewForgotPasswordButtonLabelKerning {   return @0.5f;    }
- (NSNumber*)LOGWelcomeViewForgotPasswordButtonBorderWidth  {   return @0.0f;    }

- (UIColor*)LOGWelcomeViewJustVisitingButtonLabelColor      {   return [UIColor blackColor];  }
- (NSNumber*)LOGWelcomeViewJustVisitingButtonLabelKerning   {   return @0.5f;    }
- (NSNumber*)LOGWelcomeViewJustVisitingButtonBorderWidth    {   return @0.0f;    }

- (UIColor*)LOGWelcomeViewCancelResetButtonLabelColor       {   return [UIColor blackColor];  }
- (NSNumber*)LOGWelcomeViewCancelResetButtonLabelKerning    {   return @0.5f;    }
- (NSNumber*)LOGWelcomeViewCancelResetButtonBorderWidth     {   return @0.0f;    }

//
// SignIn Buttons
//
- (UIColor*)LOGWelcomeViewSignInSignInButtonLabelColor      {   return [UIColor grayColor]; }
- (UIColor*)LOGWelcomeViewSignInSignInButtonBorderColor     {   return [UIColor grayColor]; }

- (UIColor*)LOGWelcomeViewSignInValidSignInButtonBorderColor        {   return [UIColor blueColor]; }
- (UIColor*)LOGWelcomeViewSignInValidSignInButtonBackgroundColor    {   return [UIColor colorWithHexString:@"46a4eb4d"];    }

- (UIColor*)LOGWelcomeViewSignInKeyboardSignInButtonLabelColor              {   return [UIColor grayColor]; }
- (UIColor*)LOGWelcomeViewSignInKeyboardSignInButtonBorderColor             {   return [UIColor grayColor]; }

- (UIColor*)LOGWelcomeViewSignInKeyboardValidSignInButtonBorderColor        {   return [UIColor blueColor]; }
- (UIColor*)LOGWelcomeViewSignInKeyboardValidSignInButtonBackgroundColor    {   return [UIColor colorWithHexString:@"46a4eb4d"];    }

- (UIColor*)LOGWelcomeViewSignInProcessingSignInButtonLabelColor    {   return [UIColor grayColor]; }
- (UIColor*)LOGWelcomeViewSignInProcessingSignInButtonBorderColor   {   return [UIColor grayColor]; }

- (UIColor*)LOGWelcomeViewSignInErrorSignInButtonLabelColor     {   return [UIColor grayColor]; }
- (UIColor*)LOGWelcomeViewSignInErrorSignInButtonBorderColor    {   return [UIColor grayColor]; }

//
// ResetPassword Buttons
//
- (UIColor*)LOGWelcomeViewResetPasswordResetPasswordButtonLabelColor      {   return [UIColor grayColor]; }
- (UIColor*)LOGWelcomeViewResetPasswordResetPasswordButtonBorderColor     {   return [UIColor grayColor]; }

- (UIColor*)LOGWelcomeViewResetPasswordValidResetPasswordButtonBorderColor        {   return [UIColor blueColor]; }
- (UIColor*)LOGWelcomeViewResetPasswordValidResetPasswordButtonBackgroundColor    {   return [UIColor colorWithHexString:@"46a4eb4d"];    }

- (UIColor*)LOGWelcomeViewResetPasswordKeyboardResetPasswordButtonLabelColor              {   return [UIColor grayColor]; }
- (UIColor*)LOGWelcomeViewResetPasswordKeyboardResetPasswordButtonBorderColor             {   return [UIColor grayColor]; }

- (UIColor*)LOGWelcomeViewResetPasswordKeyboardValidResetPasswordButtonBorderColor        {   return [UIColor blueColor]; }
- (UIColor*)LOGWelcomeViewResetPasswordKeyboardValidResetPasswordButtonBackgroundColor    {   return [UIColor colorWithHexString:@"46a4eb4d"];    }

- (UIColor*)LOGWelcomeViewResetPasswordProcessingResetPasswordButtonLabelColor    {   return [UIColor grayColor]; }
- (UIColor*)LOGWelcomeViewResetPasswordProcessingResetPasswordButtonBorderColor   {   return [UIColor grayColor]; }

- (UIColor*)LOGWelcomeViewResetPasswordErrorResetPasswordButtonLabelColor     {   return [UIColor grayColor]; }
- (UIColor*)LOGWelcomeViewResetPasswordErrorResetPasswordButtonBorderColor    {   return [UIColor grayColor]; }

//
// TextField Defaults
//
- (UIFont*)TextFieldFont                {   return [UIFont customFontWithName:@"ProximaNova-Regular" size:18.0f];   }

- (NSNumber*)TextFieldHorizontalPadding {   return @10.0f;  }
- (NSNumber*)TextFieldVerticalPadding   {   return @0.0f;   }

- (UIColor*)TextFieldBorderColor        {   return [UIColor whiteColor];    }

- (NSNumber*)TextFieldBorderWidth       {   return @1.0f;    }

- (UIFont*)TextFieldPlaceholderFont     {   return [UIFont customFontWithName:@"ProximaNova-Regular" size:18.0f];   }
- (UIColor*)TextFieldPlaceholderColor   {   return [UIColor colorWithWhite:1.0f alpha:0.6f];    }

//
// View Defaults
//
- (UIColor*)LOGWelcomeViewErrorBannerBubbleViewBackgroundColor                      {   return [UIColor colorWithHexString:@"e6001c"];  }
- (UIColor*)LOGWelcomeViewResetPasswordSuccessErrorBannerBubbleViewBackgroundColor  {   return [UIColor colorWithHexString:@"00640c"];  }

//
// ImageView Defaults
//
- (UIColor*)LOGWelcomeViewErrorBannerNippleImageViewBackgroundColor                     {   return [UIColor colorWithPatternImage:[UIImage imageNamed:@"btnErrorNipple"]];      }
- (UIColor*)LOGWelcomeViewResetPasswordSuccessErrorBannerNippleImageViewBackgroundColor {   return [UIColor colorWithPatternImage:[UIImage imageNamed:@"btnSuccessNipple"]];    }


@end
