//
//  SubcategoriesView.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 27.01.21.
//

import SwiftUI

struct SubcategoriesView: View {
    
    let category: Category
    
    @Binding var presentation: PresentationMode
    
    @EnvironmentObject private var addRecord: AddRecordViewModel
    
    @SwiftUI.State private var searchText: String = ""
    
    var body: some View {
        
        ZStack {
            
            Color("primaryBg").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                SearchBar(searchText: $searchText)
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Button(action: {
                            self.addRecord.chosenCategory = category
                            self.addRecord.isCategoryChosen = true 
                            presentation.dismiss()
                        }) {
                            CategoryView(category: category, showChildren: false)
                        }
                        .padding(.bottom)
                        
                        Text("Subcategories")
                            .nunitoFont(size: 18, weight: .semiBold, color: .mcGray)
                        
                        let subcategoriesEmpty = category.subcategories.isEmpty
                        let hideSubcategories = category.subcategories.allSatisfy{( !$0.show )}
                        let searchedSubcategoriesEmpty = category.subcategories.filter({$0.currentName.lowercased().contains(searchText.lowercased()) || searchText.isEmpty}).isEmpty
                        
                        let searchedSubcategories = category.subcategories.filter({$0.currentName.lowercased().contains(searchText.lowercased()) || searchText.isEmpty})
                        
                        if subcategoriesEmpty || hideSubcategories || searchedSubcategoriesEmpty {
                            
                            LazyVStack(alignment: .center, spacing: 20) {
                                Text("There are no such subcategories")
                                    .nunitoFont(size: 20, weight: .bold, color: .mcGrayText)
                                
                                Button(action: {}) {
                                    Text("Add new subcategory")
                                        .nunitoFont(size: 18, weight: .bold, color: .white)
                                        .padding(10)
                                        .background(Color.mcGreen)
                                        .cornerRadius(10)
                                }
                                
                            }
                            
                        } else {
                            
                            VStack(spacing: 10) {
                                
                                ForEach(searchedSubcategories) { subcategory in
                                    
                                    Button(action: {
                                        self.addRecord.chosenCategory = subcategory
                                        self.addRecord.isCategoryChosen = true
                                        presentation.dismiss()
                                    }) {
                                        CategoryView(category: subcategory, showChildren: false)
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                }
            }
            
        }
        .navigationBarTitle(category.currentName, displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {}) {
                                    Image(systemName: "plus")
                                }
        )
        .simultaneousGesture(
            DragGesture().onChanged({ (value) in
                if value.translation.height > 0 {
                    self.hideKeyboard()
                }
            })
        )
        
    }
}

//struct SubcategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubcategoriesView(category: Category.example, chosenCategory: .constant(Category.example), isChosen: .constant(false))
//    }
//}
