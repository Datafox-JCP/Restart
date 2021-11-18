//
//  HomeView.swift
//  Restart
//
//  Created by Juan Carlos Pazos on 18/10/21.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    // MARK: -  Body
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Header
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(Animation
                                .easeInOut(duration: 4)
                                .repeatForever()
                               , value: isAnimating
                    )
            } // ZStack
            
            // MARK: - Center
            Text("The road that leads to mastery is dependent on the intensity of your focus")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            // MARK: - Footer
            Spacer()
            
            Button(action: {
                withAnimation {
                    playSound(sound: "success", type: "m4a")
                    isOnboardingViewActive = true
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } // VStack
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isAnimating = true
            }
        })
    }
}


// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 13 mini")
    }
}
