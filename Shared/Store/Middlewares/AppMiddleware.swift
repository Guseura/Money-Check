//
//  AuthMiddleware.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation
import Firebase

let db = Firestore.firestore()

func appMiddleware() -> Middleware<AppState, AppAction> {
    
    return { state, action, status, dispatch in
        
        switch (action) {

        case .signOut:
            
            do {
                status.setLoading(to: true)

                try Auth.auth().signOut()

                dispatch(.reducer(.clearUser))

            } catch {


            }
        
        break
            
        default:
            break
        }
        
    }
    
}

// MARK: - Help functions

enum Errors: Error {
    case accountsAreEmpty
}

//func getUserAccounts(userId: String, completion: @escaping (Result<[Account], Error>) -> Void) {
//    
//    db.collection("users/\(userId)/accounts").getDocuments { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//            completion(.failure(err))
//        } else {
//
//            guard let documents = querySnapshot?.documents else {
//                print("Documents data is empty")
//                completion(.failure(Errors.accountsAreEmpty))
//                return
//            }
//
//            var accounts: [Account] = []
//
//            for doc in documents {
//
//                accounts.append(Account(id: doc["id"] as! String,
//                                        name: doc["name"] as! String,
//                                        type: AccountType(name: doc["type.name"] as! String, icon: doc["type.icon"] as! String),
//                                        currency: doc["currency"] as! String,
//                                        color: doc["color"] as! String,
//                                        currentBalance: doc["currentBalance"] as! Double))
//            }
//
//            completion(.success(accounts))
//        }
//    }
//    
//}

enum CategoriesConvertType {
    case firestore, appstore
}

//func convertCategoriesForApp(categories: Any) -> [Category] {
//
//    var result: [Category] = []
//
//    for category in categories as! [[String: Any]] {
//
//        result.append(Category(id: category["id"] as! String,
//                               names: category["names"] as! CategoryNames,
//                               currentName: ""
//                               icon: category["icon"] as! String,
//                               color: category["color"] as! String,
//                               show: category["show"] as! Bool,
//                               isParent: category["isParent"] as! Bool,
//                               isSubcategory: category["isSubcategory"] as! Bool,
//                               parentId: category["parentId"] as! String,
//                               subcategories: convertCategoriesForApp(categories: category["subcategories"] as! [[String: Any]])))
//
//    }
//
//    return result
//}

//func convertCategories(categories: [Category]) -> [[String: Any]] {
//
//    var result: [[String: Any]] = []
//
//    for category in categories {
//
//        result.append(
//            [
//                "id": category.id,
//                "names": [
//                    "name_en":
//                ],
//                "icon": category.icon,
//                "color": category.color,
//                "show": category.show,
//                "isParent": category.isParent,
//                "isSubcategory": category.isSubcategory,
//                "parentId": category.parentId,
//                "subcategories": convertCategories(categories: category.subcategories)
//            ]
//        )
//
//
//
//    }
//
//    return result
//
//}
