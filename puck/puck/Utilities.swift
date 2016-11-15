//
//  Utilities.swift
//  puck
//
//  Created by Taylor Guidon on 11/14/16.
//  Copyright © 2016 Taylor Guidon. All rights reserved.
//

import Cocoa
import Foundation

class Utilities {
    class func openURLInBrowser(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Error making URL")
            return
        }
        NSWorkspace.shared().open(url)
    }
}
