//
//  AppDelegate.swift
//  domates
//
//  Created by Mehmet Sinan Eris on 08.02.23.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var popover = NSPopover();
    static var shared: AppDelegate!
    public var statusBar: StatusBarController?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        popover.contentViewController = NSViewController()
        //popover.contentViewController = NSHostingController(rootView: PopoverView())
        popover.contentViewController?.view = NSHostingView(rootView: PopoverView())
        
        popover.behavior = .transient
        
        statusBar = StatusBarController(popover)
    }
}
