//
//  State.swift
//  moneycheck
//
//  Created by Yurij Gooseon 09.01.21.
//

import Foundation
import Firebase


struct AppState: State {
    var user: UserState
    var auth: AuthState
}

struct UserState: State {
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var photoURL: String = ""
    var createdAt: Timestamp = Timestamp()
    var lastSignInAt: Timestamp = Timestamp()
    
    var providers: [String] = []
    var accounts: [Account] = []
    var categories: [Category] = []
    var labels: [Label] = []
    var transactions: [Transaction] = []
}

struct AuthState: State {
    var authenticated: Bool = false
    var needVerification: Bool = false
    var authLoading: Bool = false
}


