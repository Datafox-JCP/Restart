//
//  OnboardingView.swift
//  Restart
//
//  Created by Juan Carlos Pazos on 18/10/21.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffeset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Never give in"
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    // MARK: -  BODY
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                // MARK: - HEADER
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 50, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                    Never give in. Never give in. Never give in. Never, never, never, never --in nothing, great or small, large or petty-- never give in, except to convictions of honour and good sense. Never yield to force. Never yield to the apparently overwhelming might of the enemy.
                    """)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: - CENTER
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "NEVER GIVE IN"
                                        }
                                    }
                                }
                                .onEnded{ gesture in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Never give in"
                                    }
                                }
                        ) // Gesture
                } // ZStack
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                Spacer()
                
                // MARK: - FOOTER
                ZStack {
                    // PARTS OF THE CUSTOM BUTTON
                    
                    // MARK: 1. BACKGROUND (STATIC)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // MARK: 2. CALL-TO-ACTION (STATIC)
                    Text("Get started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // MARK: 3. CAPSULE (DYNAMIC WIDTH)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffeset + 80)
                        
                        Spacer()
                    }
                    // MARK: 4. CIRCLE (DRAGGABLE)
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
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffeset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffeset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffeset = 0
                                        }
                                    }
                                }
                        ) // Gesture
                        .animation(.easeOut(duration: 1), value: imageOffset)
                        Spacer()
                    } // HStack
                } // Footer
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } // VStack
        } // ZStack
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}


// MARK: - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
