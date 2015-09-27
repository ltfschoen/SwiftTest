//
//  AppDelegate.swift
//  FreeWifiSearch
//
//  Created by LS on 2/09/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        print("AppDelegate.swift - Loading app overrides")
        /* Swift recognises the Facebook SDK method due to use of Bridging Header. Store Facebook App ID Settings in plist file.
        */
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    /* Facebook SDK fast app switching to login to Facebook app and Safari fallback.
    Project Navigator > Info > URL Types > URL Schemes "fb<INSERT_FB_APP_ID>"
    */
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool
    {
        print("AppDelegate.swift - Checking if FB wasHandled...")
        
        /* 6. Connect Application Delegate https://developers.facebook.com/docs/ios/getting-started
        */
        // Ensure Facebook SDK only sees URLs intended for it
//        let isFacebookURL = url.scheme != nil && url.scheme.hasPrefix("fb\(FBSDKSettings.appID())") && url.host == "authorize"

        // http://stackoverflow.com/questions/30729011/swift-2-migration-savecontext-in-appdelegate
        // https://gist.github.com/scottdelly/135b35966b1a8de8d2d0
        if url.scheme != "" {
            do {
                try url.scheme.hasPrefix("fb\(FBSDKSettings.appID())")

                do {
                    try url.host == "authorize"

                    return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
                } catch let error as NSError {
                    NSLog("Unresolved error \(error), \(error.userInfo)")
                    // Handle Error
                    return false
                }
            } catch let error as NSError {
                NSLog("Unresolved error \(error), \(error.userInfo)")
                // Handle Error
                return false
            }
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

        /* 7. Add App Events https://developers.facebook.com/docs/ios/getting-started
        */
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}