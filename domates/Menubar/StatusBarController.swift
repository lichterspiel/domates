//
//  StatusBarController.swift
//  domates
//
//  Created by Mehmet Sinan Eris on 08.02.23.
//

import AppKit

class StatusBarController {
    private var statusBar: NSStatusBar
    
    private(set) var statusItem: NSStatusItem
    private(set) var popover: NSPopover
    
    private var title:NSAttributedString?
    
    init(_ popover: NSPopover){
        self.popover = popover
        statusBar = .init()
        
        statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "house", accessibilityDescription: "house")
            button.action = #selector(showApp(sender:))
            button.imagePosition = .imageLeft
            button.target = self
        }
    }
    
    func setTitle(_ t: String){
        let title = NSAttributedString(
            string: " \(t)"
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
