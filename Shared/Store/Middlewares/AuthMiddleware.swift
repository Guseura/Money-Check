//
//  AuthMiddleware.swift
//  moneycheck
//
//  Created by Yurij Goose on 21.01.21.
//

import Foundation
import Firebase

func authMiddleware() -> Middleware<AppState, AppAction> {
    
    return { state, action, status, dispatch in
        
        switch action {
        
        case .auth(let action):
            
            switch action {
            
            case .signUp(let email, let password, let firstName, let lastName):
                
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    
                    if let error = error {
                        
                        status.setError(to: error)
                        
                    } else {
                        
                        guard let user = authResult?.user else {
                            status.setError(to: error)
                            return
                        }
                        
                        getDefaultCategories { (result) in
                            switch result {
                            
                            case .failure(let error):
                                print("Error getting default categories: \(error)")
                            case .success(let categories):
                                
                                
                                // Add user to database
                                db.collection("users").document("\(user.uid)").setData([
                                    "id": user.uid,
                                    "firstName": firstName,
                                    "lastName": lastName,
                                    "email": email,
                                    "photoURL": "",
                                    "createdAt": user.metadata.creationDate ?? Date(),
                                    "lastSignInAt": user.metadata.lastSignInDate ?? Date(),
                                    "providers": user.providerData.map({ (provider) -> String in
                                        return provider.providerID
                                    }),
                                ]) { error in
                                    if let error = error {
                                        status.setError(to: error)
                                    } else {
                                        
                                        for category in categories {
                                            
                                            db.collection("users/\(user.uid)/categories").document("\(category.id)").setData(category.asDictionary) { error in
                                                
                                                guard error == nil else {
                                                    print("Error writing default categories to Firestore: \(error!)")
                                                    status.setError(to: error)
                                                    return
                                                }
                                                
                                                for subcategory in category.subcategories {
                                                    
                                                    db.collection("users/\(Auth.auth().currentUser!.uid)/categories/\(category.id)/subcategories").document(subcategory.id).setData(subcategory.asDictionary) { error in
                                                        
                                                        guard error == nil else {
                                                            print("Error writing default subcategories to Firestore: \(error!)")
                                                            status.setError(to: error)
                                                            return
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                            }
                                            
                                        }
                                        
                                        
                                        
                                        let user = User(id: user.uid,
                                                        firstName: firstName,
                                                        lastName: lastName,
                                                        email: email,
                                                        photoURL: "",
                                                        createdAt: Timestamp(date: user.metadata.creationDate ?? Date()),
                                                        lastSignInAt: Timestamp( date: user.metadata.lastSignInDate ?? Date()),
                                                        providers: user.providerData.map({ (provider) -> String in
                                                            return provider.providerID
                                                        }),
                                                        accounts: [],
                                                        categories: categories,
                                                        labels: [],
                                                        transactions: [])
                                        
                                        dispatch(.auth(.reducer(.needVerification)))
                                        dispatch(.reducer(.setUser(user: user)))
                                        
                                        
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                    
                }
                
                
                
            case .signIn(let email, let password):
                
                Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                    
                    if let error = error {
                        
                        status.setError(to: error)
                        
                    } else {
                        
                        guard let user = authResult?.user else {
                            status.setError(to: error)
                            return
                        }
                        
                        dispatch(.user(.getUser(id: user.uid)))
                        
                    }
                    
                }
                
            case .signInWith(_):
                
                break
                
            case .linkProvider(_):
                
                break
                
                
            case .sendPasswordResetEmail(let email, let successMessage):
                
                Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                    
                    guard error == nil else {
                        status.setError(to: error)
                        return
                    }
                    
                    status.setSuccess(to: successMessage)
                }
                
                
            default:
                break
                
            }
            
            
        default:
            break
        }
        
    }
    
}
