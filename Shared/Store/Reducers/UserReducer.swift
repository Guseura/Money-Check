//
//  UserReducer.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation

func userReducer(state: inout UserState, action: UserAction) -> Void {
    
    switch (action) {
    
    case .reducer(let action):
        
        switch action {
        
        case .addAccount(let account):
            state.accounts.append(account)
            
        case .editAccount(let account):
        
            if let row = state.accounts.firstIndex(where: {$0.id == account.id}) {
                state.accounts[row] = account
            }
            
        case .deleteAccount(let id):
            state.accounts.removeAll(where: { $0.id == id })
            
        case .addLabel(let label):
            state.labels.append(label)
            
        case .editLabel(let label):
            
            if let row = state.labels.firstIndex(where: {$0.id == label.id}) {
                state.labels[row] = label
            }
            
        case .deleteLabel(let id):
            state.labels.removeAll(where: { $0.id == id })
            
        case .addCategory(let category):
            
            if category.isParent && !category.isSubcategory {
                
                state.categories.append(category)
                
            } else if category.isSubcategory && category.parentId != "" {
                
                if let row = state.categories.firstIndex(where: {$0.id == category.parentId}) {
                    state.categories[row].subcategories.append(category)
                }
                
            }
            
        case .editCategory(let category):
            
            
            if category.isParent && !category.isSubcategory {
                
                if let row = state.categories.firstIndex(where: {$0.id == category.id}) {
                    state.categories[row] = category
                }
                
            } else if category.isSubcategory && category.parentId != "" {
                
                if let row = state.categories.firstIndex(where: {$0.id == category.parentId}) {
                    if let index = state.categories[row].subcategories.firstIndex(where: {$0.id == category.id}) {
                        state.categories[row].subcategories[index] = category
                    }
                }
                
            }
            
        case .deleteCategory(let category):
            
            if category.isParent && !category.isSubcategory {
                
                state.categories.removeAll(where: { $0.id == category.id })
                
            } else if category.isSubcategory && category.parentId != "" {
                
                if let row = state.categories.firstIndex(where: {$0.id == category.parentId}) {
                    state.categories[row].subcategories.removeAll(where: {$0.id == category.id})
                }
                
            }
            
        case .addTransaction(let transaction):
            state.transactions.append(transaction)
            
        case .editTransaction(let transaction):
            
            if let row = state.transactions.firstIndex(where: {$0.id == transaction.id}) {
                state.transactions[row] = transaction
            }
            
        case .deleteTransaction(let id):
            state.transactions.removeAll(where: { $0.id == id })
            
        }
        
    default:
        break
    }
    
}
