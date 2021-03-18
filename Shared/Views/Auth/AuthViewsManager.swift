//
//  AuthViewsManager.swift
//  moneycheck
//
//  Created by Yurij Goose on 17.01.21.
//

import Foundation
import SwiftUI

class AuthViewsManager: ObservableObject {
    
    @Published var signInEmailPage = false
    @Published var signUpNamePage = false
    @Published var signUpEmailPage = false
    
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    func clearData() {
        firstName = ""
        lastName = ""
        email = ""
        password = ""
        confirmPassword = ""
    }
    
}
