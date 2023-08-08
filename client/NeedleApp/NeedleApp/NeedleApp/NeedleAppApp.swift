//
//  NeedleAppApp.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI
import UserNotifications

@main
struct NeedleAppApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var doc = NSAttributedString.empty
    var body: some Scene {
        WindowGroup {
            RootView()
                .frame(minWidth: 1100, minHeight: 600)
                .preferredColorScheme(.light)
        }.windowStyle(HiddenTitleBarWindowStyle())
            
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    NSApp.registerForRemoteNotifications(matching: [.alert, .sound, .badge])
                }
            }
        }
    }
    
    func application(_ application: NSApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device token: \(token)")
        NotificationService.shared.token = token
    }
    
    func application(_ application: NSApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error)")
    }
}
