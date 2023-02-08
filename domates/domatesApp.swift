//
//  domatesApp.swift
//  domates
//
//  Created by Mehmet Sinan Eris on 26.01.23.
//

import SwiftUI

@main
struct domatesApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        AppDelegate.shared = appDelegate
    }
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

