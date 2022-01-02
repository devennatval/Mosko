//
//  moskoApp.swift
//  mosko
//
//  Created by Deven Nathanael on 14/11/21.
//

import SwiftUI

@main
struct moskoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var isOnboardingViewShowing: Bool = true
    @State private var isOnboardingSettingViewShowing: Bool = true
    @StateObject var mqttManager = MQTTManager.shared()

    var body: some Scene {
        WindowGroup {
            if UDHelper.sharedUD.isNewUser() {
                if isOnboardingViewShowing {
                    OnBoardingView(isOnboardingViewShowing: $isOnboardingViewShowing)
                } else {
                    PondView(isEditSetting: true)
                }
            } else {
                PondView()
            }
            
        }
    }
}
