//
//  AppDelegate.m
//  FarEasternU
//
//  Created by Q on 7/19/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Fabric with:@[[Crashlytics class]]];

    
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"L9LqdHwA5fI6PtiEn3CRYOnSEjAVPJd5tJ7b1a2U"
                  clientKey:@"oeatKMFvGcKJz399s7xldKCpeCDL8ZinFUkyMkaX"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    // Override point for customization after application launch.
//    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
//    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
//    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
//    splitViewController.delegate = self;
    
    // Assign tab bar item with titles
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    [tabBarItem1 setImage:[UIImage imageNamed:@"icon_corse"]];
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"icon_corse_selected"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"icon_corse"]];
    
    [tabBarItem2 setImage:[UIImage imageNamed:@"icon_apply"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"icon_apply_selected"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"icon_apply"]];
    
    [tabBarItem3 setImage:[UIImage imageNamed:@"icon_news"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"icon_news_selected"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"icon_news"]];
    
    [tabBarItem4 setImage:[UIImage imageNamed:@"icon_activity"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"icon_activity_selected"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"icon_activity"]];
    
    [tabBarItem5 setImage:[UIImage imageNamed:@"icon_contact"]];
    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"icon_contact_selected"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"icon_contact"]];
    
    // Change the title color of tab bar items
    UIColor *titleHighlightedColor = [UIColor colorWithRed:255/255.0f green:240/255.0f blue:0.0f alpha:1.0f];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255/255.0f green:240/255.0f blue:0.0f alpha:1.0f]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor blackColor],
                                                           UITextAttributeFont: [UIFont fontWithName:@"ThaiSansNeue-ExtraBold" size:26.0],
                                                           }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

@end
