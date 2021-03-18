//
//  SignUpView.swift
//  moneycheck
//
//  Created by Yurij Goose on 15.01.21.
//

import SwiftUI

struct SignUpEmailView: View {
    
    @EnvironmentObject private var auth: AuthViewsManager
    @EnvironmentObject private var store: AppStore<AppState>
    @EnvironmentObject private var status: StatusViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            HStack {
                Text("SIGN_UP_TITLE")
                    .nunitoFont(size: 28, weight: .extraBold, color: .mcGrayText)
                Spacer()
            }
            
            InputFieldView(imageType: .custom, imageName: "envelope", placeholder: "SIGN_UP_EMAIL_PLACEHOLDER", type: .email, text: $auth.email)
            
            InputFieldView(imageType: .custom, imageName: "lock", placeholder: "SIGN_UP_PASSWORD_PLACEHOLDER", type: .password, text: $auth.password)
            
            InputFieldView(imageType: .custom, imageName: "lock", placeholder: "SIGN_UP_CONFIRMPASSWORD_PLACEHOLDER", type: .password, text: $auth.confirmPassword)
            
            HStack {
                Button(action: {
                    
                    withAnimation {
                        self.auth.signUpEmailPage.toggle()
                        self.auth.signUpNamePage.toggle()
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
                    
                    //sign up
                    signUpHandler()
                    
                }) {
                    Text("SIGN_UP_BUTTON")
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
                    self.auth.signUpEmailPage.toggle()
                    self.auth.signInEmailPage.toggle()
                }
                
            }) {
                if UIScreen.main.bounds.width > 320 {
                    HStack {
                        Text("SIGN_UP_HAVE_ACCOUNT_TEXT")
                            .nunitoFont(size: 16, weight: .bold, color: .mcGrayText)
                        Text("SIGN_UP_SIGN_IN_BUTTON")
                            .nunitoFont(size: 18, weight: .extraBold, color: .mcGreen)
                    }
                } else {
                    VStack {
                        Text("SIGN_UP_HAVE_ACCOUNT_TEXT")
                            .nunitoFont(size: 16, weight: .bold, color: .mcGrayText)
                        Text("SIGN_UP_SIGN_IN_BUTTON")
                            .nunitoFont(size: 18, weight: .extraBold, color: .mcGreen)
                    }
                }
            }
            
            
        }
        
        
        
    }
    
    func signUpHandler() {
        
        status.setLoading(to: true)

        guard auth.email != "" && auth.password != "" && auth.confirmPassword != "" else {
            status.setError(to: AuthError.allFieldsRequired)
            return
        }
        
        guard auth.password == auth.confirmPassword else {
            status.setError(to: AuthError.passwordsDoNotMatch)
            return
        }
            
        store.dispatch(.auth(.signUp(email: auth.email,
                                     password: auth.password,
                                     firstName: auth.firstName,
                                     lastName: auth.lastName)))
        
    }
    
}

struct SignUpEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEmailView()
    }
}
