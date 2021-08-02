//
//  AppDelegate.m
//  streaming_platform
//
//  Created by Alexis Porras on 25/02/21.
//

#import "AppDelegate.h"
#import "MainMenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setBarTintColor:[UIColor secondaryColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont fontWithName:@"SourceSansPro-SemiBold" size:18.0f],
                                                           }];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[APWSAccess sharedInstance] performSelector:@selector(synchronizeDB) withObject:nil afterDelay:1.0];
}

@end
