//
//  ContentView.swift
//  Restart
//
//  Created by Juan Carlos Pazos on 18/10/21.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Propiedades
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

// MARK: - Vista preliminar
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
