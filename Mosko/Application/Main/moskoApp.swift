//
//  moskoApp.swift
//  mosko
//
//  Created by Deven Nathanael on 14/11/21.
//

import SwiftUI

@main
struct moskoApp: App {
    @State private var isOnboardingViewShowing: Bool = true
    @StateObject var mqttManager = MQTTManager.shared()

    init() {
        print(UDHelper.sharedUD.isNewUser())
    }
    var body: some Scene {
        WindowGroup {
            if UDHelper.sharedUD.isNewUser() {
                if isOnboardingViewShowing {
                    OnBoardingView(isOnboardingViewShowing: $isOnboardingViewShowing)
                }
                else {
                    PondView()
                }
            } else {
                PondView()
            }
            
        }
    }
}
