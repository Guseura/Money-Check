//
//  SignInView.swift
//  moneycheck
//
//  Created by Yurij Goose on 11.01.21.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var auth = AuthViewsManager()
    
    @SwiftUI.State private var email = ""
    @SwiftUI.State private var password = ""
    
    var body: some View {
        
        ZStack {
            Color("signInBg")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                
                Spacer()
                
                HStack(spacing: 20) {
                    Image("launchIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .cornerRadius(20)
                    Text("MoneyCheck")
                        .nunitoFont(size: 30, weight: .extraBold, color: .mcGrayText)
                }
                
                if !auth.signInEmailPage && !auth.signUpNamePage && !auth.signUpEmailPage {
                    Spacer()
                    
                    Text("SIGN_PAGE_TITLE")
                        .nunitoFont(size: 40, weight: .bold, color: .mcText)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.7)
                    
                }
                
                Spacer()
                
                if auth.signInEmailPage {
                    
                    SignInWithEmailView()
                        .transition(.asymmetric(
                                        insertion: AnyTransition.opacity.combined(with: .scale),
                                        removal: AnyTransition.opacity.combined(with: .move(edge: .trailing))))
                    
                } else if auth.signUpNamePage {
                    
                    SignUpNameView()
                        .transition(.asymmetric(
                                        insertion: AnyTransition.opacity.combined(with: .scale),
                                        removal: AnyTransition.opacity.combined(with: .move(edge: .trailing))))
                    
                } else if auth.signUpEmailPage {
                    
                    SignUpEmailView()
                        .transition(.asymmetric(
                                        insertion: AnyTransition.opacity.combined(with: .scale),
                                        removal: AnyTransition.opacity.combined(with: .move(edge: .trailing))))
                    
                } else {
                    
                    SignInHomeView()
                        .transition(.asymmetric(
                                        insertion: AnyTransition.opacity.combined(with: .scale),
                                        removal: AnyTransition.opacity.combined(with: .move(edge: .trailing))))
                    
                }
                
                
            }
            .padding(.horizontal)
            
        }
        .navigationBarHidden(true)
        .environmentObject(auth)
        
    }
}

struct ActivityIndicator: View {
    
    let style = StrokeStyle(lineWidth: 3, lineCap: .round)
    let color1 = Color.mcGreen
    let color2 = Color.mcGreen.opacity(0.5)
    
    @SwiftUI.State private var animate = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(AngularGradient(gradient: .init(colors: [color1, color2]), center: .center),
                        style: style)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.4).repeatForever(autoreverses: false))
        }
        .onAppear {
            self.animate.toggle()
        }
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignInView()
            SignInView()
                .preferredColorScheme(.dark)
        }
        
    }
}

struct SignInButtonSmall: View {
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("signInButton"))
            .frame(width: 70, height: 70)
            .shadow(color: .mcShadow, radius: 15, x: 0, y: 1)
            .overlay(
                Image(imageName)
                    .resizable()
                    .frame(maxWidth: 30, maxHeight: 30)
                    .scaledToFit()
            )
    }
}

struct SignInHomeView: View {
    
    @EnvironmentObject private var auth: AuthViewsManager
    
    var body: some View {
        VStack(spacing: 20) {
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("signInButton"))
                    .frame(height: 70)
                    .shadow(color: .mcShadow, radius: 15, x: 0, y: 1)
                    .overlay(
                        HStack(spacing: 20) {
                            Image(systemName: "applelogo")
                                .resizable()
                                .frame(width: 15, height: 19)
                                .scaledToFit()
                                .accentColor(.mcText)
                            Text("SIGN_IN_WITH_APPLE")
                                .nunitoFont(size: 16, weight: .bold, color: .mcText)
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("signInBg"))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image("arrow-right")
                                        .resizable()
                                        .frame(width: 18)
                                        .scaledToFit()
                                )
                        }
                        .padding(.horizontal, 20)
                    )
            })
            
            HStack(spacing: 30) {
                Rectangle()
                    .fill(Color.mcGray)
                    .frame(height: 1, alignment: .leading)
                Text("SIGN_PAGE_OR")
                    .nunitoFont(size: 14, weight: .semiBold, color: .mcGray)
                Rectangle()
                    .fill(Color.mcGray)
                    .frame(height: 1, alignment: .trailing)
            }
            
            HStack(spacing: 20) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    SignInButtonSmall(imageName: "googleIcon")
                    
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    SignInButtonSmall(imageName: "facebookIcon")
                })
                Button(action: {
                    
                    self.auth.clearData()
                    withAnimation {
                        self.auth.signInEmailPage.toggle()
                    }
                    
                }) {
                    SignInButtonSmall(imageName: "emailIcon")
                }
            }
            
        }
        .padding(.bottom, 100)
        
    }
}
