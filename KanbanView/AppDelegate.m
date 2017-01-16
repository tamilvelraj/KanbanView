//
//  AppDelegate.m
//  KanbanView
//
//  Created by Thamil Selvan V on 10/01/17.
//  Copyright © 2017 Thamil Selvan V. All rights reserved.
//

#import "AppDelegate.h"
#import "ZViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+(int)randN:(int)maxN
{
    int randN = rand()%maxN;
    return (randN==0)?1: randN;
}

+(int)betweenRandN:(int)minN :(int)maxN
{
    int randN = rand()%maxN;
    while (randN < minN) {
        randN = rand()%maxN;
    }
    return randN;
}

+(CGFloat)gridScreenWidth {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

+(CGFloat)gridScreenHeight {
    return CGRectGetHeight([UIScreen mainScreen].bounds) - 64.f;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ZViewController *controller = [[ZViewController alloc] init];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = controller;
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
