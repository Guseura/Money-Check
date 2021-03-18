//
//  Label.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation

struct Label: Identifiable {
    
    let id: String
    let name: String
    let color: RGBColor
    let show: Bool
    var isExceeded = false
    
    var asDictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "color": [
                "red": color.red,
                "green": color.green,
                "blue": color.blue
            ],
            "show": show,
        ]
    }
    
    static let example = Label(id: UUID().uuidString, name: "Label", color: .init(red: 0.230655, green: 0.509701, blue: 0.967435), show: true)
}

struct RGBColor: Codable {
    let red: Double
    let green: Double
    let blue: Double
}


