//
//  Account.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation

struct Account: Identifiable, Equatable {
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func != (lhs: Account, rhs: Account) -> Bool {
        return lhs.id != rhs.id
    }
    
    var id: String
    var name: String
    var type: AccountType
    var currency: String
    var color: RGBColor
    var currentBalance: Double
    var show: Bool
    
    var asDictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "type": [
                "name": type.name,
                "icon": type.icon
            ],
            "currency": currency,
            "color": [
                "red": color.red,
                "green": color.green,
                "blue": color.blue
            ],
            "currentBalance": currentBalance,
            "show": show
        ]
    }
    
    static let example = Account(id: UUID().uuidString, name: "Account", type: .init(name: "Bank", icon: "Icon"), currency: "USD", color: .init(red: 0, green: 0, blue: 0), currentBalance: 415, show: true)
    
    static let transfer = Account(id: UUID().uuidString, name: "Out of Wallet", type: .init(name: "Out of Wallet", icon: ""), currency: "", color: .init(red: 0.123, green: 0.41, blue: 0.12), currentBalance: 0, show: true)
}


struct AccountType {
    var name: String
    var icon: String
}
