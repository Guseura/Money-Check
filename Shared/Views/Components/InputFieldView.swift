//
//  InputFieldView.swift
//  moneycheck
//
//  Created by Yurij Goose on 14.01.21.
//

import SwiftUI

enum InputFieldType {
    case email
    case password
    case text
}

enum InputFieldImageType {
    case system, custom
}

struct InputFieldView: View {
    
    let imageType: InputFieldImageType
    let imageName: String
    let placeholder: LocalizedStringKey
    let type: InputFieldType
    let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    @Binding var text: String
    
    @SwiftUI.State private var showPassword = false
    
    var body: some View {
        
        HStack {
            
            if imageType == .custom {
                
                Image(imageName)
                    .renderingMode(.template)
                    .foregroundColor(.mcGreen)
                
            } else if imageType == .system {
                Image(systemName: imageName)
                    .renderingMode(.template)
                    .foregroundColor(.mcGreen)
            }
            
            if type == .password {
                
                if showPassword {
                    
                    TextField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .frame(height: 60)
                    
                } else {
                    SecureField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .frame(height: 60)
                }
                
                Button(action: {
                    self.showPassword.toggle()
                }) {
                    Image(showPassword ? "eye-crossed" : "eye")
                        .renderingMode(.template)
                        .foregroundColor(.mcGreen)
                }
                
            } else {
                
                TextField(placeholder, text: $text)
                    .frame(height: 60)
                    .keyboardType(type == .email ? .emailAddress : .default)
                    .autocapitalization(type == .email ? .none : .sentences)
                
            }
            
        }
        .nunitoFont(size: 18, weight: .semiBold, color: .mcGrayText)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("signInButton"))
        )
        
    }
}

//struct InputFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputFieldView(placeholder: "Email", type: .email, text: Binding()
//    }
//}
