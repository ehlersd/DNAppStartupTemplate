//
//  AppDelegate.m
//  Application
//
//  Created by Darren Ehlers on 12/13/2013.
//  Copyright (c) 2013 DoubleNode, LLC. All rights reserved.
//

#include <Crashlytics/Crashlytics.h>
#include <HockeySDK/HockeySDK.h>

#import <MessageUI/MFMailComposeViewController.h>
#import <MTMigration/MTMigration.h>

#import "Flurry.h"
#import "BugButton.h"

#import "AppDelegate.h"
#import "AppConstants.h"
#import "AppThemeManager.h"
#import "AppThemeBase.h"

#import "AFHTTPRequestOperationLogger.h"
#import "AnalyticsKitFlurryProvider.h"
#import "DNUtilities.h"

#import "CDConstantsDataModel.h"
#import "CDConstantModel.h"

#import "DNDataModel.h"
#import "AFIncrementalStore.h"
//#import "MainIncrementalStore.h"

#if CREATING_SCREENSHOTS
#import "AppScreenshotManager.h"
#endif

@interface AppDelegate () <BITHockeyManagerDelegate, BITUpdateManagerDelegate, BITCrashManagerDelegate, BugButtonDelegate, MFMailComposeViewControllerDelegate>
{
    BOOL    isReachableFlag;

    BugButton*  bugButton;

    NSURLCache* URLCache;
}

@end

@implementation AppDelegate

#ifdef DEBUG
+ (void)initialize {
    [[NSUserDefaults standardUserDefaults] setValue:@"XCTestLog,GTMCodeCoverageTests"
                                             forKey:@"XCTestObserverClass"];
}
#endif

+ (BOOL)isRunningUnitTests
{
    return NO;
}

- (UIViewController*)rootViewController
{
    return self.window.rootViewController;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [[DNUtilities sharedInstance] logDisableDomain:LD_UnitTests];
        [[DNUtilities sharedInstance] logEnableDomain:LD_General];
        [[DNUtilities sharedInstance] logEnableDomain:LD_Framework];
        [[DNUtilities sharedInstance] logEnableDomain:LD_CoreData];
        [[DNUtilities sharedInstance] logEnableDomain:LD_ViewState];
        [[DNUtilities sharedInstance] logDisableDomain:LD_Theming];
    }
    
    return self;
}

- (void)appVersionMigration
{
    [MTMigration applicationUpdateBlock:^
     {
         // Run on EVERY version number increase
     }];

    [MTMigration migrateToVersion:@"1.0.0" block:^
     {
         // Run first time upgrading to (or beyond) v1.0.0
     }];
}

- (void)initializeTools
{
    NSString*   betaID  = [AppConstants hockeyAppBetaID];
    NSString*   liveID  = [AppConstants hockeyAppLiveID];
    if ([liveID isEqualToString:@"-1"] == YES)
    {
        [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:betaID
                                                               delegate:self];
    }
    else
    {
        [[BITHockeyManager sharedHockeyManager] configureWithBetaIdentifier:betaID
                                                             liveIdentifier:liveID
                                                                   delegate:self];
    }
    
    [[BITHockeyManager sharedHockeyManager] startManager];
    DLog(LL_Debug, LD_General, @"HockeyApp Initialized - Live:%@, Beta:%@", [AppConstants hockeyAppLiveID], [AppConstants hockeyAppBetaID]);

    [Crashlytics startWithAPIKey:[AppConstants crashlyticsApiKey]];
    DLog(LL_Debug, LD_General, @"Crashlytics Initialized - %@", [AppConstants crashlyticsApiKey]);

    AnalyticsKitFlurryProvider* flurry = [[AnalyticsKitFlurryProvider alloc] initWithAPIKey:[AppConstants flurryApiKey]];
    [AnalyticsKit initializeLoggers:@[flurry]];

    // DME: Disable Flurry Crash Reporting (provided by Crashlytics)
    [Flurry setCrashReportingEnabled:NO];

    [AnalyticsKit logEvent:@"initializeTools"];
    DLog(LL_Debug, LD_General, @"Flurry Initialized - %@", [AppConstants flurryApiKey]);
}

#pragma mark - BITUpdateManagerDelegate

- (NSString *)customDeviceIdentifierForUpdateManager:(BITUpdateManager *)updateManager
{
#ifdef DEBUG
    if ([[UIDevice currentDevice] respondsToSelector:@selector(uniqueIdentifier)])
        return [[UIDevice currentDevice] performSelector:@selector(uniqueIdentifier)];
#endif
    return nil;
}

#pragma mark - BugButtonDelegate

- (void)addBugButton:(UIView*)view
{
#ifdef DEBUG
    // DME: Disabled for now...[view addSubview:bugButton];
#endif
}

- (void)removeBugButton:(UIView*)view
{
#ifdef DEBUG
    // DME: Disabled for now...[bugButton removeFromSuperview];
#endif
}

#ifdef DEBUG
- (void)reportBug:(BugButton*)sender
{
    DLog(LL_Debug, LD_General, @"BUG REPORT");

    if (![MFMailComposeViewController canSendMail])
    {
        UIAlertView*    cannotEmailAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:@"This device is not set up to send email."
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil, nil];
        [cannotEmailAlert show];
        return;
    }

    MFMailComposeViewController*    mailViewController = [[MFMailComposeViewController alloc] init];
    [mailViewController setMailComposeDelegate:self];
    [mailViewController setToRecipients:@[@"darren.ehlers@gatewaystaff.com"]];
    [mailViewController setSubject:@"Phoenix - Bug Report"];
    [mailViewController setMessageBody:[sender bugReportString] isHTML:NO];
    [mailViewController addAttachmentData:[sender getScreenshot] mimeType:@"image/jpeg" fileName:@"screenshot"];

    UIViewController*   topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    [topController presentViewController:mailViewController animated:YES completion:nil];

    [sender removeFromSuperview];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    UIViewController*   topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }

    [topController dismissViewControllerAnimated:YES completion:nil];
    [topController.view addSubview:bugButton];
}
#endif

#pragma mark - Application delegate functions

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self setDoNotUseIncrementalStore:YES];
    
    DLog(LL_Debug, LD_Framework, @"didFinishLaunchingWithOptions");
    DLog(LL_Debug, LD_Framework, @"Device IP Address: %@", [DNUtilities getIPAddress]);
    //DLog(LL_Debug, LD_Framework, @"SQLite URL: %@", [[self getPersistentStoreURL:@"Main"] absoluteString]);

    URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024
                                             diskCapacity:20 * 1024 * 1024
                                                 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    [[AFHTTPRequestOperationLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    //[[AFHTTPRequestOperationLogger sharedLogger] setLevel:AFLoggerLevelError];

    if ([AppDelegate isRunningUnitTests] == YES)
    {
        // DME: Skip Tool Setup
        DLog(LL_Debug, LD_General, @"HockeyApp, Crashlytics & Flurry Skipped Due To Unit Testing");
    }
    else
    {
        BOOL    resetFlag   = [AppConstants resetConstants];
        if (resetFlag == YES)
        {
            [AppConstants reloadAllConstants];
        }

        [DNUtilities runAfterDelay:10.0f
                             block:^
         {
             [self initializeTools];
         }];
    }

    [AppThemeManager customizeAppAppearance];

#if CREATING_SCREENSHOTS
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        AppScreenshotManager*   screenshotManager = [[AppScreenshotManager alloc] init];

        [screenshotManager setLOGWelcomeVC:[[LOGWelcomeViewController alloc] initWithNibName:nil bundle:nil]];
        [screenshotManager takeScreenshots];
    });
#endif

#if DEBUG
    // DME: Disabled for now...bugButton = [BugButton bugButton];
    // DME: Disabled for now...bugButton.delegate = self;
    // DME: Disabled for now...[self.window addSubview:bugButton];
#endif

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //Decided NOT to save contexts automatically when entering background.  App code is responsible for saving it's own updates.
    //[self saveAllContexts];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];

#ifdef DEBUG
#if CREATING_SCREENSHOTS
#else   // CREATING_SCREENSHOTS
    extern void __gcov_flush(void);
    __gcov_flush();
#endif  // CREATING_SCREENSHOTS
#endif
}

#pragma mark - CoreData DNApplicationProtocol functions

- (void)disableURLCache
{
    [URLCache removeAllCachedResponses];
    URLCache    = nil;
}

- (void)deletePersistentStore
{
    DLog(LL_Debug, LD_CoreData, @"Should NOT be here!");

    NSException*    exception = [NSException exceptionWithName:@"AppDelegate Exception"
                                                        reason:@"Base deletePersistentStore should never be called, override might be missing!"
                                                      userInfo: nil];
    @throw exception;
}

- (void)saveContext
{
    DLog(LL_Debug, LD_CoreData, @"Should NOT be here!");

    NSException*    exception = [NSException exceptionWithName:@"AppDelegate Exception"
                                                        reason:@"Base saveContext should never be called, override might be missing!"
                                                      userInfo: nil];
    @throw exception;
}

- (NSManagedObjectContext*)managedObjectContext
{
    DLog(LL_Debug, LD_CoreData, @"Should NOT be here!");

    NSException*    exception = [NSException exceptionWithName:@"AppDelegate Exception"
                                                        reason:@"Base managedObjectContext should never be called, override might be missing!"
                                                      userInfo: nil];
    @throw exception;

    // Not sure if this is ever reached
    return nil;
}

- (NSManagedObjectModel*)managedObjectModel
{
    DLog(LL_Debug, LD_CoreData, @"Should NOT be here!");

    NSException*    exception = [NSException exceptionWithName:@"AppDelegate Exception"
                                                        reason:@"Base managedObjectModel should never be called, override might be missing!"
                                                      userInfo: nil];
    @throw exception;

    return nil;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    DLog(LL_Debug, LD_CoreData, @"Should NOT be here!");

    NSException*    exception = [NSException exceptionWithName:@"AppDelegate Exception"
                                                        reason:@"Base persistentStoreCoordinator should never be called, override might be missing!"
                                                      userInfo: nil];
    @throw exception;

    return nil;
}

- (NSPersistentStore*)persistentStore
{
    DLog(LL_Debug, LD_CoreData, @"Should NOT be here!");

    NSException*    exception = [NSException exceptionWithName:@"AppDelegate Exception"
                                                        reason:@"Base persistentStore should never be called, override might be missing!"
                                                      userInfo: nil];
    @throw exception;
    
    return nil;
}

- (void)deletePersistentStore:(Class)modelClass
{
    [[modelClass dataModel] deletePersistentStore];
}

- (void)saveContext:(Class)modelClass
{
    [[modelClass dataModel] saveContext];
}

//Explicitly write Core Data accessors
- (NSManagedObjectContext*)managedObjectContext:(Class)modelClass
{
    return [[modelClass dataModel] managedObjectContext];
}

- (NSManagedObjectModel*)managedObjectModel:(Class)modelClass
{
    return [[modelClass dataModel] managedObjectModel];
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator:(Class)modelClass
{
    return [[modelClass dataModel] persistentStoreCoordinator];
}

- (NSPersistentStore*)persistentStore:(Class)modelClass
{
    return [[modelClass dataModel] persistentStore];
}

#pragma mark - NSUserDefaults settings items

- (id)settingsItem:(NSString*)item
{
    return [self settingsItem:item default:@""];
}

- (id)settingsItem:(NSString*)item default:(id)defaultValue
{
    NSString*   key     = [NSString stringWithFormat:@"Setting_%@", item];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] == nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:defaultValue forKey:key];
    }
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (id)settingsItem:(NSString*)item boolDefault:(BOOL)defaultValue
{
    return [self settingsItem:item default:(defaultValue ? @"1" : @"0")];
}

- (void)setSettingsItem:(NSString*)item value:(id)value
{
    NSString*   key     = [NSString stringWithFormat:@"Setting_%@", item];
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setSettingsItem:(NSString*)item boolValue:(BOOL)value;
{
    [self setSettingsItem:item value:(value ? @"1" : @"0")];
}

@end
