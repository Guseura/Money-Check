//
//  SignUpNameView.swift
//  moneycheck
//
//  Created by Yurij Goose on 17.01.21.
//

import SwiftUI

struct SignUpNameView: View {
    
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
            
            InputFieldView(imageType: .custom, imageName: "profile", placeholder: "SIGN_UP_FIRSTNAME_PLACEHOLDER", type: .text, text: $auth.firstName)
            
            InputFieldView(imageType: .custom, imageName: "profile", placeholder: "SIGN_UP_LASTNAME_PLACEHOLDER", type: .text, text: $auth.lastName)
            
            
            HStack {
                Button(action: {
                    
                    self.auth.clearData()
                    withAnimation {
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
                    
                    signUpNameHandler()
                    
                }) {
                    Text("SIGN_UP_NEXT_BUTTON")
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
            .padding(.top, 42)
            
            
            
            
            Button(action: {
                
                self.auth.clearData()
                withAnimation {
                    self.auth.signUpNamePage.toggle()
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
    
    func signUpNameHandler() {
        
        status.setLoading(to: true)
        guard auth.firstName != "" && auth.lastName != "" else {
            status.setError(to: AuthError.allFieldsRequired)
            return
        }
            
        withAnimation {
            self.auth.signUpNamePage.toggle()
            self.auth.signUpEmailPage.toggle()
            status.setLoading(to: false)
        }
        
    }
    
}

struct SignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNameView()
    }
}
