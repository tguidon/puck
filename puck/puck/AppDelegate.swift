//
//  AppDelegate.swift
//  puck
//
//  Created by Taylor Guidon on 11/14/16.
//  Copyright © 2016 Taylor Guidon. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var getNewPostsMenuItem: NSMenuItem!
    @IBOutlet weak var soundEnabledMenuItem: NSMenuItem!
    
    let waitTime: TimeInterval = 60.0
    let url = "https://www.reddit.com/r/hockey/new/.json"
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -1)
    let defaults = UserDefaults.standard
    let nhl = NHL()
    var timer = Timer()
    var redditData = RedditData(title: nil, url: nil)
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // notification delegate
        NSUserNotificationCenter.default.delegate = self
        
        // setup menubar icon
        let icon = NSImage(named: "MenuIcon")
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        // setup UI
        getNewPostsMenuItem.state = 1
        soundEnabledMenuItem.state = 1
        defaults.set(true, forKey: "soundEnabled")
        
        // schedule and start the reddit polling by default
        scheduleTimer()
    }
    
    // MARK: - User Notification Center Delegate Methods
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        if (notification == notification) {
            guard let urlString = notification.userInfo?["url"] as? String,
                let url = URL(string: urlString) else {
                    print("Error: Building url from notification string")
                    return
            }
            NSWorkspace.shared().open(url)
        }
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

    
    // MARK: - UX Interactions
    @IBAction func toggleGetNewPosts(_ sender: NSMenuItem) {
        if sender.state == NSOnState {
            sender.state = NSOffState
            timer.invalidate()
        } else {
            sender.state = NSOnState
            scheduleTimer()
        }
    }
    
    @IBAction func toggleSound(_ sender: NSMenuItem) {
        if sender.state == NSOnState {
            sender.state = NSOffState
            defaults.set(false, forKey: "soundEnabled")
        } else {
            sender.state = NSOnState
            defaults.set(true, forKey: "soundEnabled")
        }
    }
    
    @IBAction func openURL(_ sender: NSMenuItem) {
        switch sender.tag {
        case 0:
            Utilities.openURLInBrowser("https://www.reddit.com/r/hockey/new/")
        case 1:
            Utilities.openURLInBrowser("https://www.reddit.com/r/hockey/")
        case 2:
            Utilities.openURLInBrowser("https://www.nhl.com")
        default:
            print("Error: Menu item's tag means nothing.")
        }
    }
    
    @IBAction func quitApp(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    
    // MARK: - Show Notification of new post
    func showNotification(_ title: String,_ url: String) -> Void {
        let notification = NSUserNotification()
        notification.title = "New Post in r/hockey 🏒"
        notification.informativeText = title
        notification.userInfo = ["url": url]
        notification.hasActionButton = true
        
        let sound = defaults.bool(forKey: "soundEnabled")
        if sound {
            notification.soundName = NSUserNotificationDefaultSoundName
        } else {
            notification.soundName = nil
        }
        
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    
    // MARK: - Reddit Data Polling
    func scheduleTimer() {
        timer = Timer.scheduledTimer(timeInterval: waitTime, target: self,
                                     selector: #selector(AppDelegate.pollHockeyData), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func pollHockeyData() {
        getHockeyData(url: url)
    }
    
    func getHockeyData(url: String) {
        Alamofire.request(url)
            .responseJSON { response in
                guard let data = response.result.value else {
                    print("Error: Data does not exist")
                    return
                }
                
                let json = JSON(data)
                guard let title = json["data"]["children"][0]["data"]["title"].string,
                    let url = json["data"]["children"][0]["data"]["url"].string else {
                        print("Error: Title of URL invalid")
                        return
                }
                
                if url != self.redditData.url {
                    self.redditData.title = title
                    self.redditData.url = url
                    self.showNotification(title, url)
                }
        }
    }
}
