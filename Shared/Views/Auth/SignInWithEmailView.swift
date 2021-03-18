//
//  SignInWithEmailView.swift
//  moneycheck
//
//  Created by Yurij Goose on 14.01.21.
//

import SwiftUI

struct SignInWithEmailView: View {
    
    @EnvironmentObject private var store: AppStore<AppState>
    @EnvironmentObject private var auth: AuthViewsManager
    @EnvironmentObject private var status: StatusViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            HStack {
                Text("SIGN_IN_TITLE")
                    .nunitoFont(size: 28, weight: .extraBold, color: .mcGrayText)
                Spacer()
            }
            
            InputFieldView(imageType: .custom, imageName: "envelope", placeholder: "SIGN_IN_EMAIL_PLACEHOLDER", type: .email, text: $auth.email)
            
            InputFieldView(imageType: .custom, imageName: "lock", placeholder: "SIGN_IN_PASSWORD_PLACEHOLDER", type: .password, text: $auth.password)
            
            HStack {
                Spacer()
                Button(action: {
                    self.passwordRecoveryHandler()
                    
//                    store.status.loading.toggle()
//                    store.status.setError(to: AuthError.emptyFields)
                    
                }) {
                    Text("SIGN_IN_FORGOT_PASSWORD")
                        .nunitoFont(size: 16, weight: .bold, color: .mcGrayText)
                }
            }
            
            
            HStack {
                Button(action: {
                    
                    self.auth.clearData()
                    withAnimation {
                        self.auth.signInEmailPage.toggle()
                    }
                    
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("signInButton"))
                        .frame(width: 60, height: 50)
                        .overlay(
                            Image("arrow-right")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.mcGreen)
                                .frame(width: 20)
                                .scaledToFit()
                                .rotationEffect(.init(degrees: 180))
                        )
                }
                Spacer()
                Button(action: {
                    signInHandler()
                }) {
                    Text("SIGN_IN_BUTTON")
                        .nunitoFont(size: 18, weight: .extraBold, color: .mcGreen)
                        .padding(.horizontal, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("signInButton"))
                                .frame(height: 50)
                        )
                }
            }
            .padding(.bottom, 50)
            
            
            
            
            Button(action: {
                
                self.auth.clearData()
                withAnimation {
                    self.auth.signInEmailPage.toggle()
                    self.auth.signUpNamePage.toggle()
                }
                
            }) {
                if UIScreen.main.bounds.width > 320 {
                    HStack {
                        Text("SIGN_IN_NEW_ACCOUNT_TEXT")
                            .nunitoFont(size: 16, weight: .bold, color: .mcGrayText)
                        Text("SIGN_IN_SIGN_UP_BUTTON")
                            .nunitoFont(size: 18, weight: .extraBold, color: .mcGreen)
                    }
                } else {
                    VStack {
                        Text("SIGN_IN_NEW_ACCOUNT_TEXT")
                            .nunitoFont(size: 16, weight: .bold, color: .mcGrayText)
                        Text("SINN_IN_SIGN_UP_BUTTON")
                            .nunitoFont(size: 18, weight: .extraBold, color: .mcGreen)
                    }
                }
            }
            
            
        }
    }
    
    func signInHandler() {
        
        status.setLoading(to: true)
        
        guard auth.email != "" || auth.password != "" else {
            status.setError(to: AuthError.allFieldsRequired)
            return
        }
        
        store.dispatch(.auth(.signIn(email: auth.email, password: auth.password)))
    }
    
    func passwordRecoveryHandler() {
        
        status.setLoading(to: true)
        store.dispatch(.auth(.sendPasswordResetEmail(email: auth.email, successMessage: "Check your email for futher instructions!")))
        
    }
    
}

struct SignInWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                SignInWithEmailView()
                SignInWithEmailView()
                    .colorScheme(.dark)
                
            }
        }
    }
}
