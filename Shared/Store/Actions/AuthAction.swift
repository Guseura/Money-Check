//
//  AuthAction.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation

enum AuthAction: Action {
    
    // Middleware
    case signUp(email: String, password: String, firstName: String, lastName: String)
    case signIn(email: String, password: String)
    case signInWith(provider: String)
    case linkProvider(provider: String)
    case unlinkProvider(providerId: String)
    case addPassword(password: String)
    case updatePassword(currPassword: String, newPassword: String)
    case updateEmail(email: String, password: String)
    case updateProfile(imageFile: Any, firstName: String, lastName: String)
    case sendPasswordResetEmail(email: String, successMessage: String)
    
    case reducer(_ action: AuthReducerAction)
    
}

enum AuthReducerAction {
    case needVerification
    case setLoading(loading: Bool)
}

