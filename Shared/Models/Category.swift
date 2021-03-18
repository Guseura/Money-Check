//
//  Category.swift
//  moneycheck
//
//  Created by Yurij Goose on 10.01.21.
//

import Foundation

struct Category: Identifiable, Codable {
    var id: String
    var names: CategoryNames?
    var currentName: String = ""
    var icon: String
    var color: RGBColor
    var show: Bool
    var isParent: Bool
    var isSubcategory: Bool
    var parentId: String
    var subcategories: [Category]
    
    var asDictionary: [String: Any] {
        return [
            "id": id,
            "names": names != nil ? [
                "name_en": names?.name_en ?? "",
                "name_ru": names?.name_ru ?? ""
            ] : names as Any,
            "currentName": currentName,
            "icon": icon,
            "color": [
                "red": color.red,
                "green": color.green,
                "blue": color.blue
            ],
            "show": show,
            "isParent": isParent,
            "isSubcategory": isSubcategory,
            "parentId": parentId,
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case id, names, icon, color, show, isParent, isSubcategory, parentId, subcategories
    }
    
    static let example = Category(id: "", names: .init(name_en: "", name_ru: ""), currentName: "", icon: "", color: .init(red: 0, green: 0, blue: 0), show: true, isParent: false, isSubcategory: false, parentId: "", subcategories: [])
}

struct CategoryNames: Codable {
    var name_en: String
    var name_ru: String
}
