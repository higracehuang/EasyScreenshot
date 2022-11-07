//
//  AppDelegate.swift
//  EasyScreenshot
//
//  Created by Le Huang on 10/31/22.
//

import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var menuExtrasConfigurator: MacExtrasConfigurator?
    
    final private class MacExtrasConfigurator: NSObject {
        
        private var statusBar: NSStatusBar
        private var statusItem: NSStatusItem
        
        override init() {
            statusBar = NSStatusBar.system
            statusItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
            super.init()
            createMenu()
        }
        
        private func createMenu() {
            if let statusBarButton = statusItem.button {
                statusBarButton.image = NSImage(
                    systemSymbolName: "cursorarrow.rays",
                    accessibilityDescription: nil
                )
                
                let mainMenu = NSMenu()
                
                /// Creating menu item: area capture
                let itemSelectArea = NSMenuItem(
                    title: "Select an area",
                    action: #selector(Self.actionSelectArea(_:)),
                    keyEquivalent: "")
                itemSelectArea.image = NSImage(
                    systemSymbolName: "rectangle.dashed",
                    accessibilityDescription: nil
                )
                itemSelectArea.target = self
                mainMenu.addItem(itemSelectArea)
                
                /// Creating menu item: entire screen capture
                let itemCaptureEntireScreen = NSMenuItem(
                    title: "Screenshot the entire screen",
                    action: #selector(Self.actionCaptureEntireScreen(_:)),
                    keyEquivalent: "")
                itemCaptureEntireScreen.image = NSImage(
                    systemSymbolName: "macwindow.on.rectangle",
                    accessibilityDescription: nil
                )
                itemCaptureEntireScreen.target = self
                mainMenu.addItem(itemCaptureEntireScreen)
                
                /// Creating menu item: window capture
                let itemCaptureWindow = NSMenuItem(
                    title: "Capture a window",
                    action: #selector(self.actionCaptureWindow(_:)),
                    keyEquivalent: "")
                itemCaptureWindow.image = NSImage(
                    systemSymbolName: "macwindow",
                    accessibilityDescription: nil
                )
                itemCaptureWindow.target = self
                mainMenu.addItem(itemCaptureWindow)

                /// Creating a divider
                mainMenu.addItem(.separator())
                
                /// Creating menu item:  quit the app
                let itemQuit = NSMenuItem(
                    title: "Quit EasyScreenshot",
                    action: #selector(self.actionExitApp(_:)),
                    keyEquivalent: "")
                itemQuit.target = self
                mainMenu.addItem(itemQuit)
                
                statusItem.menu = mainMenu
            }
        }
        
        @objc private func actionExitApp(_ sender: Any?) {
            /// Exit the app
            NSApp.terminate(self)
        }
        
        enum ScreenshotType {
            case EntireScreen
            case Window
            case UserSelection
        }
        
        @objc private func actionCaptureEntireScreen(_ sender: Any?) {
            screenshot(type: .EntireScreen)
        }
        
        @objc private func actionSelectArea(_ sender: Any?) {
            screenshot(type: .UserSelection)
        }
        
        @objc private func actionCaptureWindow(_ sender: Any?) {
            screenshot(type: .Window)
        }
        
        func screenshot(type: ScreenshotType) {
            let task = Process()
            task.launchPath = "/usr/sbin/screencapture"
            
            switch type {
            case .EntireScreen:
                task.arguments = ["-cm"]
            case .Window:
                task.arguments = ["-cw"]
            case .UserSelection:
                task.arguments = ["-cs"]
            }
            
            task.launch()
            task.waitUntilExit()
        }
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        menuExtrasConfigurator = .init()
    }
}


