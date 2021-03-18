//
//  Actions.swift
//  moneycheck
//
//  Created by Yurij Goose on 09.01.21.
//

import Foundation

enum AppAction: Action {
    
    // Middleware
    case user(_ action: UserAction)
    case auth(_ action: AuthAction)

    case signOut
    
    case reducer(_ action: AppReducerAction)
}

enum AppReducerAction {
    case setUser(user: User)
    case clearUser

}
