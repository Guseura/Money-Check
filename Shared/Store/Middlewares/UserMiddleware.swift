//
//  UserMiddleware.swift
//  moneycheck
//
//  Created by Yurij Goose on 21.01.21.
//

import Foundation
import Firebase

func userMiddleware() -> Middleware<AppState, AppAction> {
    
    return { state, action, status, dispatch in
        
        switch action {
        
        case .user(let action):
            
            switch (action) {
            
            case .getUser(let id):
                
                db.collection("users").document(id).getDocument { (document, error) in
                    if let error = error {
                        status.setError(to: error)
                        return
                    }
                    
                    if let document = document, document.exists {
                        
                        guard let res = document.data() else {
                            print("Document data is empty")
                            return
                        }
                        
                        getUserInfo { (result) in
                            switch result {
                            case .failure(let error):
                                print(error)
                            case .success(let info):
                                
                                let user = User(id: res["id"] as! String,
                                                firstName: res["firstName"] as! String,
                                                lastName: res["lastName"] as! String,
                                                email: res["email"] as! String,
                                                photoURL: res["photoURL"] as! String,
                                                createdAt: res["createdAt"] as! Timestamp,
                                                lastSignInAt: res["lastSignInAt"] as! Timestamp,
                                                providers: res["providers"] as! [String],
                                                accounts: info["accounts"] as! [Account],
                                                categories: info["categories"] as! [Category],
                                                labels: info["labels"] as! [Label],
                                                transactions: info["transactions"] as! [Transaction])
                                
                                dispatch(.reducer(.setUser(user: user)))
                                dispatch(.auth(.reducer(.setLoading(loading: false))))
                                
                            }
                        }
                        
                        
                    }
                    
                }
                
            case .addAccount(let account):
                
                db.collection("users/\(Auth.auth().currentUser!.uid)/accounts").document(account.id).setData(account.asDictionary) { error in
                    
                    guard error == nil else {
                        print("Error writing account to Firestore: \(error!)")
                        status.setError(to: error)
                        return
                    }
                    
                    dispatch(.user(.reducer(.addAccount(account: account))))
                    hapticFeedback(.success)
                }
                
            case .editAccount(let account):
                
                db.collection("users/\(Auth.auth().currentUser!.uid)/accounts").document(account.id).updateData(account.asDictionary) { (error) in
                    
                    if let error = error {
                        print("Error updating account: \(error)")
                        status.setError(to: error)
                    } else {
                        dispatch(.user(.reducer(.editAccount(account: account))))
                        hapticFeedback(.success)
                    }
                    
                }
                
            case .deleteAccount(let id):
                
                db.collection("users/\(Auth.auth().currentUser!.uid)/accounts").document(id).delete() { error in
                    if let error = error {
                        print("Error removing account: \(error)")
                        status.setError(to: error)
                    } else {
                        dispatch(.user(.reducer(.deleteAccount(id: id))))
                        hapticFeedback(.success)
                        
                    }
                }
                
            case .addLabel(let label):
                
                db.collection("users/\(Auth.auth().currentUser!.uid)/labels").document(label.id).setData(label.asDictionary) { error in
                    
                    guard error == nil else {
                        print("Error writing label to Firestore: \(error!)")
                        status.setError(to: error)
                        return
                    }
                    
                    dispatch(.user(.reducer(.addLabel(label: label))))
                    hapticFeedback(.success)
                }
                
            case .editLabel(let label):
                
                db.collection("users/\(Auth.auth().currentUser!.uid)/labels").document(label.id).updateData(label.asDictionary) { error in
                    
                    guard error == nil else {
                        print("Error updating label: \(error!)")
                        status.setError(to: error)
                        return
                    }
                    
                    dispatch(.user(.reducer(.editLabel(label: label))))
                    hapticFeedback(.success)
                }
                
            case .deleteLabel(let id):
                
                db.collection("users/\(Auth.auth().currentUser!.uid)/labels").document(id).delete() { error in
                    
                    guard error == nil else {
                        print("Error deleting label: \(error!)")
                        status.setError(to: error)
                        return
                    }
                    
                    dispatch(.user(.reducer(.deleteLabel(id: id))))
                    hapticFeedback(.success)
                }
                
            case .addCategory(let category):
                
                if category.isParent && !category.isSubcategory {
                    
                    db.collection("users/\(Auth.auth().currentUser!.uid)/categories").document(category.id).setData(category.asDictionary) { error in
                        
                        guard error == nil else {
                            print("Error writing category to Firestore: \(error!)")
                            status.setError(to: error)
                            return
                        }
                        
                        dispatch(.user(.reducer(.addCategory(category: category))))
                        hapticFeedback(.success)
                        
                    }
                    
                } else if category.isSubcategory && category.parentId != "" {
                    
                    db.collection("users/\(Auth.auth().currentUser!.uid)/categories/\(category.parentId)/subcategories").document(category.id).setData(category.asDictionary) { error in
                        
                        guard error == nil else {
                            print("Error writing subcategory to Firestore: \(error!)")
                            status.setError(to: error)
                            return
                        }
                        
                        dispatch(.user(.reducer(.addCategory(category: category))))
                        hapticFeedback(.success)
                        
                    }
                    
                }
                
            case .editCategory(let category):
                
                if category.isParent && !category.isSubcategory {
                    
                    db.collection("users/\(Auth.auth().currentUser!.uid)/categories").document(category.id).updateData(category.asDictionary) { error in
                        
                        guard error == nil else {
                            print("Error updating category: \(error!)")
                            status.setError(to: error)
                            return
                        }
                        
                        dispatch(.user(.reducer(.editCategory(category: category))))
                        hapticFeedback(.success)
                    }
                    
                } else if category.isSubcategory && category.parentId != "" {
                    
                    db.collection("users/\(Auth.auth().currentUser!.uid)/categories/\(category.parentId)/subcategories").document(category.id).updateData(category.asDictionary) { error in
                        
                        guard error == nil else {
                            print("Error updating subcategory: \(error!)")
                            status.setError(to: error)
                            return
                        }
                        
                        dispatch(.user(.reducer(.editCategory(category: category))))
                        hapticFeedback(.success)
                    }
                    
                }
                
            case .deleteCategory(let category):
                
                if category.isParent && !category.isSubcategory {
                    
                    db.collection("users/\(Auth.auth().currentUser!.uid)/categories").document(category.id).delete() { error in
                        
                        guard error == nil else {
                            print("Error deleting category: \(error!)")
                            status.setError(to: error)
                            return
                        }
                        
                        for subcategory in category.subcategories {
                            db.collection("users/\(Auth.auth().currentUser!.uid)/categories/\(category.id)/subcategories").document(subcategory.id).delete() { error in
                                
                                guard error == nil else {
                                    print("Error deleting subcategory: \(error!)")
                                    status.setError(to: error)
                                    return
                                }
                                
                            }
                        }
                        
                        dispatch(.user(.reducer(.deleteCategory(category: category))))
                        hapticFeedback(.success)
                        
                    }
                    
                }  else if category.isSubcategory && category.parentId != "" {
                    
                    db.collection("users/\(Auth.auth().currentUser!.uid)/categories/\(category.parentId)").document(category.id).delete() { error in
                        
                        guard error == nil else {
                            print("Error deleting subcategory: \(error!)")
                            status.setError(to: error)
                            return
                        }
                        
                        dispatch(.user(.reducer(.deleteCategory(category: category))))
                        hapticFeedback(.success)
                    }
                    
                }
                
            case .addTransaction(let transaction):
                
                db.collection("users/\(Auth.auth().currentUser!.uid)/transactions").document(transaction.id).setData(transaction.asDictionary) { error in
                    
                    guard error == nil else {
                        print("Error adding a transaction: \(error!)")
                        status.setError(to: error)
                        return
                    }
                    
                    dispatch(.user(.reducer(.addTransaction(transaction: transaction))))
                    hapticFeedback(.success)
                }
                
            case .editTransaction(let transaction):
                
                db.collection("users/\(Auth.auth().currentUser!.uid)/transactions").document(transaction.id).updateData(transaction.asDictionary) { error in
                    
                    guard error == nil else {
                        print("Error updating a transaction: \(error!)")
                        status.setError(to: error)
                        return
                    }
                    
                    dispatch(.user(.reducer(.editTransaction(transaction: transaction))))
                    hapticFeedback(.success)
                }
                
            case .deleteTransaction(let id):
                db.collection("users/\(Auth.auth().currentUser!.uid)/transactions").document(id).delete() { error in
                    
                    guard error == nil else {
                        print("Error deleting a transaction: \(error!)")
                        status.setError(to: error)
                        return
                    }
                    
                    dispatch(.user(.reducer(.deleteTransaction(id: id))))
                    hapticFeedback(.success)
                }
                break
                
            default:
                break
                
            }
            
            
        default:
            break
            
        }
        
    }
    
}

func getUserInfo(completion: @escaping (Result<[String:Any], Error>) -> Void) {
    
    let userId = Auth.auth().currentUser!.uid
    
    var returnInfo: [String:Any] = [:]
    
    let group = DispatchGroup()
    
    group.enter()
    
    getUserAccounts(userId: userId) { (result) in
        switch result {
        case .failure(let error):
            completion(.failure(error))
            group.leave()
        case .success(let accounts):
            returnInfo["accounts"] = accounts
            group.leave()
        }
    }
    
    group.enter()
    
    getUserLabels(userId: userId) { (result) in
        switch result {
        case .failure(let error):
            completion(.failure(error))
            group.leave()
        case .success(let labels):
            returnInfo["labels"] = labels
            group.leave()
        }
    }
    
    group.enter()
    
    getUserTransactions(userId: userId) { (result) in
        switch result {
        case .failure(let error):
            completion(.failure(error))
            group.leave()
        case .success(let transactions):
            returnInfo["transactions"] = transactions
            group.leave()
        }
    }
    
    group.enter()
    
    getUserCategories(userId: userId) { (result) in
        switch result {
        case .failure(let error):
            completion(.failure(error))
            group.leave()
        case .success(let categories):
            returnInfo["categories"] = categories
            group.leave()
        }
    }
    
    group.notify(queue: .main) {
        completion(.success(returnInfo))
    }
    
}

func getUserAccounts(userId: String, completion: @escaping (Result<[Account], Error>) -> Void) {
    
    db.collection("users/\(userId)/accounts").getDocuments { (querySnapshot, err) in
        if let err = err {
            print("Error getting accounts: \(err)")
            completion(.failure(err))
        } else {
            
            guard let documents = querySnapshot?.documents else {
                print("Documents data is empty")
                completion(.failure(Errors.accountsAreEmpty))
                return
            }
            
            var accounts: [Account] = []
            
            for doc in documents {
                
                accounts.append(Account(id: doc["id"] as! String,
                                        name: doc["name"] as! String,
                                        type: AccountType(name: doc["type.name"] as! String,
                                                          icon: doc["type.icon"] as! String),
                                        currency: doc["currency"] as! String,
                                        color: RGBColor(red: doc["color.red"] as! Double,
                                                        green: doc["color.green"] as! Double,
                                                        blue: doc["color.blue"] as! Double),
                                        currentBalance: doc["currentBalance"] as! Double,
                                        show: doc["show"] as! Bool))
            }
            
            completion(.success(accounts))
        }
    }
    
}

func getUserLabels(userId: String, completion: @escaping (Result<[Label], Error>) -> Void) {
    
    db.collection("users/\(userId)/labels").getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error getting labels: \(error)")
            completion(.failure(error))
        } else {
            
            guard let documents = querySnapshot?.documents else {
                print("Documents data is empty")
                completion(.failure(Errors.accountsAreEmpty))
                return
            }
            
            var labels: [Label] = []
            
            for doc in documents {
                
                labels.append(Label(id: doc["id"] as! String,
                                    name: doc["name"] as! String,
                                    color: RGBColor(red: doc["color.red"] as! Double,
                                                    green: doc["color.green"] as! Double,
                                                    blue: doc["color.blue"] as! Double),
                                    show: doc["show"] as! Bool))
            }
            
            completion(.success(labels))
        }
    }
    
}

func getUserCategories(userId: String, completion: @escaping (Result<[Category], Error>) -> Void) {
    
    db.collection("users/\(userId)/categories").getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error getting categories: \(error)")
            completion(.failure(error))
        } else {
            
            guard let documents = querySnapshot?.documents else {
                print("Categories data is empty")
                completion(.failure(Errors.accountsAreEmpty))
                return
            }
            
            var categories: [Category] = []
            let group = DispatchGroup()
            
            for doc in documents {
                group.enter()
                
                getCategorySubcategories(categoryId: doc["id"] as! String) { (result) in
                    switch result {
                    case .failure(_):
                        break
                    case .success(let subcategories):
                        
                        defer { group.leave() }
                        
                        let currentNameExists = (doc["currentName"] as! String) != ""
                        
                        categories.append(Category(id: doc["id"] as! String,
                                                   names: currentNameExists ?
                                                    nil :
                                                    CategoryNames(name_en: doc["names.name_en"] as! String,
                                                                  name_ru: doc["names.name_ru"] as! String),
                                                   currentName: getCategoryCurrentName(doc: doc),
                                                   icon: doc["icon"] as! String,
                                                   color: RGBColor(red: doc["color.red"] as! Double,
                                                                   green: doc["color.green"] as! Double,
                                                                   blue: doc["color.blue"] as! Double),
                                                   show: doc["show"] as! Bool,
                                                   isParent: doc["isParent"] as! Bool,
                                                   isSubcategory: doc["isSubcategory"] as! Bool,
                                                   parentId: doc["parentId"] as! String,
                                                   subcategories: subcategories))
                        
                    }
                }
                
                
                
            }
            group.notify(queue: .main) {
                completion(.success(categories))
                print("Out")
            }
        }
    }
    
}

func getCategoryCurrentName(doc: QueryDocumentSnapshot) -> String {
    
    if (doc["currentName"] as! String) != "" {
        
        return doc["currentName"] as! String
        
    } else {
        
        guard let lang = Bundle.main.preferredLocalizations.first else {
            return doc["names.name_en"] as! String
            
        }
        switch lang {
        case "en":
            return doc["names.name_en"] as! String
        case "ru":
            return doc["names.name_ru"] as! String
            
        default:
            return doc["names.name_en"] as! String
        }
        
    }
}

func getCategorySubcategories(categoryId: String, completion: @escaping (Result<[Category], Error>) -> Void) {
    
    db.collection("users/\(Auth.auth().currentUser!.uid)/categories/\(categoryId)/subcategories").getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error getting categories: \(error)")
            completion(.failure(error))
        } else {
            
            guard let documents = querySnapshot?.documents else {
                print("Categories data is empty")
                completion(.failure(Errors.accountsAreEmpty))
                return
            }
            
            var subcategories: [Category] = []
            
            for doc in documents {
                
                print(doc["id"] as! String)
                
                let currentNameExists = (doc["currentName"] as! String) != ""
                
                subcategories.append(Category(id: doc["id"] as! String,
                                              names: currentNameExists ?
                                                nil :
                                                CategoryNames(name_en: doc["names.name_en"] as! String,
                                                              name_ru: doc["names.name_ru"] as! String),
                                              currentName: getCategoryCurrentName(doc: doc),
                                              icon: doc["icon"] as! String,
                                              color: RGBColor(red: doc["color.red"] as! Double,
                                                              green: doc["color.green"] as! Double,
                                                              blue: doc["color.blue"] as! Double),
                                              show: doc["show"] as! Bool,
                                              isParent: doc["isParent"] as! Bool,
                                              isSubcategory: doc["isSubcategory"] as! Bool,
                                              parentId: doc["parentId"] as! String,
                                              subcategories: []))
                
            }
            
            completion(.success(subcategories))
            
        }
    }
    
}

func getUserTransactions(userId: String, completion: @escaping (Result<[Transaction], Error>) -> Void) {
    
    db.collection("users/\(userId)/transactions").getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error getting transactions: \(error)")
            completion(.failure(error))
        } else {
            
            guard let documents = querySnapshot?.documents else {
                print("Transactions data is empty")
                completion(.failure(Errors.accountsAreEmpty))
                return
            }
            
            var transactions: [Transaction] = []
            
            for doc in documents {
                
                transactions.append(Transaction(id: doc["id"] as! String,
                                                amount: doc["amount"] as! Double,
                                                type: TransactionType(rawValue: doc["type"] as! String)!,
                                                date: doc["date"] as! Timestamp,
                                                categoryId: doc["categoryId"] as! String,
                                                accountId: doc["accountId"] as! String,
                                                destAccountId: doc["destAccountId"] as! String,
                                                labelIds: doc["labelIds"] as! [String],
                                                currency: doc["currency"] as! String,
                                                note: doc["note"] as! String))
                
            }
            
            completion(.success(transactions))
            
        }
    }
    
}
