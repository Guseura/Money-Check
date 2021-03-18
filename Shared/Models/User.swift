//
//  User.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation
import Firebase

struct User: Identifiable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var photoURL: String
    var createdAt: Timestamp
    let lastSignInAt: Timestamp
    
    var providers: [String]
    var accounts: [Account]
    var categories: [Category]
    var labels: [Label]
    var transactions: [Transaction]
    
    var asDictionary: [String: Any] {
        return [
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "photoURL": photoURL,
            "createdAt": createdAt,
            "lastSignInAt": lastSignInAt,
            "providers": providers,
        ]
    }
    
}
