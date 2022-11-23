//
//  EasyScreenshotApp.swift
//  EasyScreenshot
//
//  Created by Le Huang on 10/31/22.
//

import SwiftUI

@main
struct EasyScreenshotApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
