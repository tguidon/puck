//
//  AppDelegate.swift
//  puck
//
//  Created by Taylor Guidon on 11/14/16.
//  Copyright © 2016 Taylor Guidon. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var getNewPostsMenuItem: NSMenuItem!
    @IBOutlet weak var soundEnabledMenuItem: NSMenuItem!
    
    let url = "https://www.reddit.com/r/hockey/new/.json"


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // MARK: - User Notification Center Delegate Methods
    func userNotificationCenter(center: NSUserNotificationCenter,
                                didActivateNotification notification: NSUserNotification) {
        if (notification == notification) {
            if let urlString = notification.userInfo?["url"] as? String,
                let url = NSURL(string: urlString) {
                NSWorkspace.shared().open(url as URL)
            }
        }
    }
    
    func userNotificationCenter(center: NSUserNotificationCenter,
                                shouldPresentNotification notification: NSUserNotification) -> Bool {
        return true
    }


}

