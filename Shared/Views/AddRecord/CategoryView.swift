//
//  CategoryView.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 27.01.21.
//

import SwiftUI

struct CategoryView: View {
    
    let category: Category
    let showChildren: Bool
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            if category.icon == "" {
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.mcGray)
            } else {
                Image(category.icon)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.mcGray)
                    .background(Color(red: category.color.red, green: category.color.green, blue: category.color.blue))
            }
            
            
            Text(category.currentName)
                .nunitoFont(size: 18, weight: .semiBold, color: .mcText)
            
            Spacer()
            
            if category.isParent && !category.subcategories.isEmpty && !category.isSubcategory && showChildren {
                Image(systemName: "chevron.right")
                    .nunitoFont(size: 16, weight: .regular, color: .mcGray)
            }
        }
        .padding()
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("secondaryBg"))
        )
        
    }
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category.example, showChildren: true)
    }
}
