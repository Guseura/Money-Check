//
//  Authreducer.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation

func authReducer(state: inout AuthState, action: AuthAction) -> Void {
    
    switch (action) {
    
    case .reducer(let action):
        
        switch action {
        
        case .needVerification:
            state.needVerification = true
            
        case .setLoading(let loading):
            state.authLoading = loading
            
        }
        
        
    default:
        break
        
    }
    
}
