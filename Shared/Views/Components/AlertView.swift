//
//  ErrorView.swift
//  moneycheck
//
//  Created by Yurij Goose on 15.01.21.
//

import SwiftUI

enum AlertType {
    case error, success, loading
}

struct AlertView: View {
    
    let type: AlertType
    let text: String
    @Binding var show: Bool
    
    var body: some View {
        
                Group {
                    if type == .loading {
                        
                        HStack(spacing: 15) {
                            
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(width: 30, height: 30)
                            Text("Processing")
                                .nunitoFont(size: 20, weight: .extraBold, color: .mcGrayText)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .background(
                            Capsule()
                                .fill(Color("signInButton"))
                        )
                        .frame(width: UIScreen.main.bounds.width - 70)
                        
                    } else if type == .error {
                        
                        HStack {
                            Text(text)
                                .nunitoFont(size: 18, weight: .bold, color: .white)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .background(
                            Capsule()
                                .fill(Color.red)
                        )
                        .frame(width: UIScreen.main.bounds.width - 70)
                        
                    } else if type == .success {
                        
                        HStack {
                            Text(text)
                                .nunitoFont(size: 18, weight: .bold, color: .white)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .background(
                            Capsule()
                                .fill(Color.mcGreen)
                        )
                        .frame(width: UIScreen.main.bounds.width - 70)
                        
                        
                    }
                }
                .onAppear {
                    if type != .loading {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                self.show = false
                            }
                        }
                    }
                }
        
    }
}
