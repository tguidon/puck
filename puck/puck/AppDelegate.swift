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
    
    struct redditData {
        var title: String?
        var url: String?
    }
    
    var data = redditData(title: nil, url: nil)
    
    let waitTime: TimeInterval = 60.0
    let url = "https://www.reddit.com/r/hockey/new/.json"
    
    let nhl = NHL()
    var timer = Timer()
    let statusItem = NSStatusBar.system().statusItem(withLength: -1)
    let defaults = UserDefaults.standard
    
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

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // MARK: - User Notification Center Delegate Methods
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        if (notification == notification) {
            if let urlString = notification.userInfo?["url"] as? String,
                let url = NSURL(string: urlString) {
                NSWorkspace.shared().open(url as URL)
            }
        }
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
    
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    func scheduleTimer() {
        timer = Timer.scheduledTimer(timeInterval: waitTime, target: self,
                                                       selector: #selector(AppDelegate.pollHockeyData), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    // MARK: - Show Notification of new post
    
    func showNotification(title: String, url: String) -> Void {
        let notification = NSUserNotification()
        
        notification.title = "New Post in r/hockey 🏒"
        notification.informativeText = title
        notification.userInfo = ["url": url]
        
        let sound = defaults.bool(forKey: "soundEnabled")
        if sound {
            notification.soundName = NSUserNotificationDefaultSoundName
        } else {
            notification.soundName = nil
        }
        
        notification.isPresented
        notification.hasActionButton = true
        
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    func pollHockeyData() {
        getHockeyData(url: url)
    }
    
    func getHockeyData(url: String) {
        Alamofire.request(url)
            .responseJSON { response in
                
                if let data = response.result.value {
                    let json = JSON(data)
                    
                    if let title = json["data"]["children"][0]["data"]["title"].string,
                        let url = json["data"]["children"][0]["data"]["url"].string {
                        if url != self.data.url {
                            self.data.title = title
                            self.data.url = url
                            
                            self.showNotification(title: title, url: url)
                        }
                    } else {
                        print("Error: \(json["data"]["children"][0]["data"]["title"])")
                        print("Error: \(json["data"]["children"][0]["data"]["url"])")
                    }
                }
        }
    }

}

