//
//  Store.swift
//  moneycheck (iOS)
//
//  Created by Yurij Goose on 09.01.21.
//

import Foundation
import Combine

protocol Action {}
protocol State {}

typealias Store<State> = AppStore<State>

typealias Reducer<State, Action> = (inout State, Action, StatusViewModel) -> Void

// Dispatcher is a function that takes in an action and returns nothing
typealias Dispatcher = (AppAction) -> Void

// Middleware is a function defined on a StateState that takes in that State, an Action and a Dispatcher and returns nothing
typealias Middleware <State, Action> = (State, Action, StatusViewModel, @escaping Dispatcher) -> Void

final class AppStore<AppState>: ObservableObject {
    @Published private(set) var state: AppState
    
    private let reducer: Reducer<AppState, AppAction>
    private let middlewares: [Middleware<AppState, AppAction>]
    
    @Published public var status: StatusViewModel
    
    init(initState: AppState, reducer: @escaping Reducer<AppState, AppAction>, middlewares: [Middleware<AppState, AppAction>] = [], status: StatusViewModel) {
        self.state = initState
        self.reducer = reducer
        self.middlewares = middlewares
        self.status = status
    }
    
    func dispatch(_ action: AppAction) {
        
        DispatchQueue.main.async {
            self.reducer(&self.state, action, self.status)
        }
        
        for mw in middlewares {
            mw(state, action, status, dispatch)
        }
    }
}
