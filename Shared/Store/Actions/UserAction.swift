//
//  UserAction.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation

enum UserAction: Action {
    
    // Middleware
    case getUser(id: String)

    case addAccount(account: Account)
    case editAccount(account: Account)
    case deleteAccount(id: String)

    case addLabel(label: Label)
    case editLabel(label: Label)
    case deleteLabel(id: String)
    
    case addCategory(category: Category)
    case editCategory(category: Category)
    case deleteCategory(category: Category)
    
    case addTransaction(transaction: Transaction)
    case editTransaction(transaction: Transaction)
    case deleteTransaction(id: String)

    
    case reducer(_ action: UserReducerAction)
}

enum UserReducerAction {
    
    case addAccount(account: Account)
    case editAccount(account: Account)
    case deleteAccount(id: String)
    
    case addLabel(label: Label)
    case editLabel(label: Label)
    case deleteLabel(id: String)
    
    case addCategory(category: Category)
    case editCategory(category: Category)
    case deleteCategory(category: Category)
    
    case addTransaction(transaction: Transaction)
    case editTransaction(transaction: Transaction)
    case deleteTransaction(id: String)
}
