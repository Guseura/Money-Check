//
//  Transaction.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation
import Firebase

struct Transaction: Identifiable {
    let id: String
    let amount: Double
    let type: TransactionType
    let date: Timestamp
    let categoryId: String
    let accountId: String
    let destAccountId: String
    let labelIds: [String]
    let currency: String
    let note: String
    
    var asDictionary: [String: Any] {
        return [
            "id": id,
            "amount": amount,
            "type": type.rawValue,
            "date": date,
            "categoryId": categoryId,
            "accountId": accountId,
            "destAccountId": destAccountId,
            "labelIds": labelIds,
            "currency": currency,
            "note": note
        ]
    }
    
}

enum TransactionType: String  {
    case income = "Income"
    case spend = "Spend"
    case transfer = "Transfer"
}
