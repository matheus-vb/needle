//
//  NeedleAppApp.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI
import UserNotifications
import Firebase

@main
struct NeedleAppApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Window("NeedleView", id: "main") {
            RootView()
                .frame(minWidth: 1100, minHeight: 600)
                .preferredColorScheme(.light)
                .ignoresSafeArea(.all)
        }.windowStyle(HiddenTitleBarWindowStyle())
            .commands{
                CommandMenu(NSLocalizedString("Atalhos", comment: "")){
                    Text(NSLocalizedString("Novo projeto/atividade", comment: ""))
                        .keyboardShortcut("n", modifiers: .command)
                    Text(NSLocalizedString("Buscar", comment: ""))
                        .keyboardShortcut("f", modifiers: .command)
                    Text(NSLocalizedString("Novo projeto", comment: ""))
                        .keyboardShortcut(.tab, modifiers: .command)
                }
            }
        
        
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
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
    }
    
    func application(_ application: NSApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        //print("Device token: \(token)")
        NotificationDataService.shared.token = token
    }
    
    func application(_ application: NSApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error)")
    }
}
