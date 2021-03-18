////
////  File.swift
////  moneycheck
////
////  Created by Yurij Goose on 15.01.21.
////
//
//import Foundation
//
//ZStack {
//
//    Color("signInBg")
//        .edgesIgnoringSafeArea(.all)
//
//    ZStack(alignment: .topLeading) {
//
//        ZStack {
//
//            VStack {
//
//                Spacer()
//
//                HStack(spacing: 20) {
//                    Image("launchIcon")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 80, height: 80)
//                        .cornerRadius(20)
//                    Text("MoneyCheck")
//                        .font(.custom("Nunito-ExtraBold", size: 30))
//                }
//
//                Spacer()
//
//                VStack(spacing: 20) {
//
//                    InputFieldView(placeholder: "Email", type: .email, text: $email)
//                    InputFieldView(placeholder: "Password", type: .password, text: $password)
//
//                    Button(action: {
//                        signInHandler()
//                    }, label: {
//                        RoundedRectangle(cornerRadius: 15)
//                            .fill(Color.mcGreen)
//                            .frame(height: 60)
//                            //                            .shadow(color: Color("shadow"), radius: 15, x: 0, y: 1)
//                            .overlay(
//                                Text("Sign In")
//                                    .font(.custom("Nunito-SemiBold", size: 20))
//                                    .foregroundColor(.white)
//                            )
//                    })
//
//                    Button( action: {}, label: {
//                        Text("Forgot your password?")
//                            .font(.custom("Nunito-SemiBold", size: 14))
//                            .foregroundColor(.black)
//                    })
//
//                }
//
//                Spacer()
//
//                Button(action: {}, label: {
//                    HStack {
//                        Text("Don’t have an account yet?")
//                            .font(.custom("Nunito-SemiBold", size: 14))
//                            .foregroundColor(.black)
//                        Text("Sign up here!")
//                            .font(.custom("Nunito-ExtraBold", size: 16))
//                            .foregroundColor(Color("green"))
//                    }
//                })
//
//            }
//            .padding(.horizontal, 20)
//        }
//
//        Button(action: {
//            self.showEmailPage.toggle()
//        }) {
//            Image(systemName: "chevron.left")
//                .font(.title)
//                .foregroundColor(.mcGray)
//        }
//        .padding()
//    }
//
//
//
//}
//.navigationBarBackButtonHidden(true)
