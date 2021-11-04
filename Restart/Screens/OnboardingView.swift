//
//  OnboardingView.swift
//  Restart
//
//  Created by Juan Carlos Pazos on 18/10/21.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Propiedades
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffeset: CGFloat = 0
    
    // MARK: -  Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                // MARK: - HEADER
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Never give in")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    Never give in. Never give in. Never give in. Never, never, never, never --in nothing, great or small, large or petty-- never give in, except to convictions of honour and good sense. Never yield to force. Never yield to the apparently overwhelming might of the enemy.
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                // MARK: - CENTER
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                } // ZStack
                
                // MARK: - FOOTER
                ZStack {
                    // PARTS OF THE CUSTOM BUTTON
                
                    // 1. BACKGROUND (STATIC)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION (STATIC)
                    Text("Get started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // 3. CAPSULE (DYNAMIC WIDTH)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffeset + 80)
                        
                        Spacer()
                    }
                    // 4. CIRCLE (DRAGGABLE)
                    HStack {
                        ZStack {
                            Circle ()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        } // ZStack
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffeset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffeset <= buttonWidth - 80 {
                                        buttonOffeset = gesture.translation.width
                                    }
                                }
                                .onEnded { _  in
                                    if buttonOffeset > buttonWidth / 2 {
                                        buttonOffeset = buttonWidth - 80
                                        isOnboardingViewActive = false
                                    } else {
                                        buttonOffeset = 0
                                    }
                                }
                        ) // Gesture
                        Spacer()
                    } // HStack
                } // Footer
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
            } // VStack
        } // ZStack
    }
}


// MARK: - Vista preliminar
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
