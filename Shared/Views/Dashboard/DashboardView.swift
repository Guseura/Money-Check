//
//  Dashboard.swift
//  moneycheck
//
//  Created by Yurij Goose on 22.01.21.
//

import SwiftUI

struct DashboardView: View {
    
    @SwiftUI.State private var color = Color(.brown)
    
    @EnvironmentObject private var store: AppStore<AppState>
    
    var body: some View {
        
        
        VStack {
            
//            ColorPicker(selection: $color, supportsOpacity: false) {
//                EmptyView()
//            }
//
//            Button("Print color") {
//                let rgb = color.description.split(separator: " ")
//                let mycolor = RGBColor(red: Double(rgb[1]) ?? 0, green: Double(rgb[2]) ?? 0, blue: Double(rgb[3]) ?? 0)
//                print(mycolor)
//            }
//
//            Text(color.description)
            Spacer()
            
            Button("Add category") {
                store.dispatch(.user(.addCategory(category: Category(id: UUID().uuidString, names: nil, currentName: "Category 1", icon: "icon", color: RGBColor(red: 0.5135, green: 0.513, blue: 0.726), show: true, isParent: true, isSubcategory: false, parentId: "", subcategories: []))))
            }
            
            Button("delete category") {
//                store.dispatch(.user(.deleteCategory(category: store.state.user.categories[0])))
                print(store.state.user.categories)
            }
            
            Spacer()
            
            Button("Add subcategory") {
                store.dispatch(.user(.addCategory(category: Category(id: UUID().uuidString, names: nil, currentName: "Subcategory 1", icon: "icon", color: RGBColor(red: 0.5135, green: 0.513, blue: 0.726), show: true, isParent: false, isSubcategory: true, parentId: "E789D6B5-EB10-4E6F-B91E-E8BCCB60792A", subcategories: []))))
            }
            
            Spacer()
            
            Button("Add account") {
                store.dispatch(.user(.addAccount(account: Account(id: UUID().uuidString, name: "Account 1", type: .init(name: "Bank", icon: "bank"), currency: "USD", color: .init(red: 0.51, green: 0.51, blue: 0.124), currentBalance: 5158, show: true))))
            }
            
            Spacer()
            
            Button("Add label") {
                store.dispatch(.user(.addLabel(label: Label(id: UUID().uuidString, name: "Label 1", color: .init(red: 0.61, green: 0.14, blue: 0.61), show: true))))
            }
            
            Spacer()
        }
        
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
