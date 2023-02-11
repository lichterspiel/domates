//
//  StatusBarController.swift
//  domates
//
//  Created by Mehmet Sinan Eris on 08.02.23.
//

import AppKit
import SwiftUI
import Foundation

class StatusBarController {
    //private var statusBar: NSStatusBar
    
    private(set) var statusItem: NSStatusItem
    private(set) var popover: NSPopover
    
    private var title: NSAttributedString?
    
    init(_ popover: NSPopover){
        self.popover = popover
        //statusBar = .init()
        //statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.imagePosition = .imageLeft
            button.image = NSImage(systemSymbolName: "leaf.fill", accessibilityDescription: "domates timer")
            button.action = #selector(showApp(sender:))
            button.target = self
        }
    }
    
    func setTitle(_ t: String){
        let title = NSAttributedString(
            string: !t.isEmpty ? " \(t)" : "",
            attributes: [NSAttributedString.Key.font: NSFont.monospacedSystemFont(ofSize: 12, weight: NSFont.Weight.regular)]
        )
        statusItem.button?.attributedTitle = title
    }
    
    @objc
    func showApp(sender: AnyObject){
        if popover.isShown{
            popover.performClose(nil)
        }
        else {
            popover.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .minY)
        }
    }
}
