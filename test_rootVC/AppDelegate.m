//
//  AppDelegate.m
//  test_rootVC
//
//  Created by 苏洗洗 on 2023/8/4.
//

#import "AppDelegate.h"
#import "ViewController1.h"
//#import ""

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    if (@available(iOS 13.0, *)) {

        }
    else {

            self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            self.window.rootViewController = [[MagicFaceViewController alloc]init];
           // self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];

        }

    return YES;

        // Override point for customization after application launch.
    

    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    MagicFaceViewController *viewController = [[MagicFaceViewController alloc] init];
//    self.window.rootViewController = viewController;
//    [self.window makeKeyAndVisible];
//    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
