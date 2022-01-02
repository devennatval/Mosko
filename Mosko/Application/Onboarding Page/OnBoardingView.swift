//
//  OnBoardingView.swift
//  mosko
//
//  Created by Deven Nathanael on 14/11/21.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var selection = 0
    @Binding var isOnboardingViewShowing: Bool
    
    var body: some View {
        VStack {
            PageTabView(selection: $selection,isOnboardingViewShowing: $isOnboardingViewShowing)
            ButtonsView(selection: $selection)
        }
        .background(.green)
        .transition(.move(edge: .bottom))
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(isOnboardingViewShowing: Binding.constant(true))
    }
}
