//
//  Reducers.swift
//  moneycheck
//
//  Created by Yurij Goose on 09.01.21.
//

import Foundation

func appReducer(state: inout AppState, action: AppAction, status: StatusViewModel) -> Void {
    
    switch (action) {
    
    case .auth(let action):
        authReducer(state: &state.auth, action: action)
        
    case .user(let action):
        userReducer(state: &state.user, action: action)
        
    case .reducer(let action):
        
        switch action {
        case .setUser(let user):
            
            state.auth.authenticated = true
            
            state.user.id = user.id
            state.user.firstName = user.firstName
            state.user.lastName = user.lastName
            state.user.email = user.email
            state.user.photoURL = user.photoURL
            state.user.createdAt = user.createdAt
            state.user.lastSignInAt = user.lastSignInAt
            
            state.user.categories = user.categories
            state.user.providers = user.providers
            state.user.accounts = user.accounts
            state.user.transactions = user.transactions
            state.user.labels = user.labels
            
            status.setLoading(to: false)
            
        case .clearUser:
            
            state.auth.authenticated = false
            status.setLoading(to: false)
            
            state.user = UserState()
            
        }

   
        
    default:
        break
        
    }
    
    
}
