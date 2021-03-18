//
//  ChooseCategoryView.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 26.01.21.
//

import SwiftUI

let categories: [Category] = [
    
    Category(id: UUID().uuidString, names: .init(name_en: "Category 1", name_ru: "Категория 1"), currentName: "Category 1", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: false, isParent: true, isSubcategory: false, parentId: "", subcategories: [
        Category(id: UUID().uuidString, names: .init(name_en: "Subcategory 1.1", name_ru: "Подкатегория 1.1"), currentName: "Subcategory 1.1", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: false, isSubcategory: true, parentId: "id", subcategories: [])
    ]),
    Category(id: UUID().uuidString, names: .init(name_en: "Category 2", name_ru: "Категория 2"), currentName: "Category 2", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: true, isSubcategory: false, parentId: "", subcategories: [
        Category(id: UUID().uuidString, names: .init(name_en: "Subcategory 2.1", name_ru: "Подкатегория 2.1"), currentName: "Subcategory 2.1", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: false, isSubcategory: true, parentId: "id", subcategories: [])
    ]),
    Category(id: UUID().uuidString, names: .init(name_en: "Category 3", name_ru: "Категория 3"), currentName: "Category 3", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: true, isSubcategory: false, parentId: "", subcategories: [
        Category(id: UUID().uuidString, names: .init(name_en: "Subcategory 3.1", name_ru: "Подкатегория 3.1"), currentName: "Subcategory 3.1", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: false, isSubcategory: true, parentId: "id", subcategories: []),
        Category(id: UUID().uuidString, names: .init(name_en: "Subcategory 3.2", name_ru: "Подкатегория 3.2"), currentName: "Subcategory 3.2", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: false, isSubcategory: true, parentId: "id", subcategories: []),
        Category(id: UUID().uuidString, names: .init(name_en: "Subcategory 3.3", name_ru: "Подкатегория 3.3"), currentName: "Subcategory 3.3", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: false, isSubcategory: true, parentId: "id", subcategories: []),
    ]),
    Category(id: UUID().uuidString, names: .init(name_en: "Category 4", name_ru: "Категория 4"), currentName: "Category 4", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: true, isSubcategory: false, parentId: "", subcategories: [
        Category(id: UUID().uuidString, names: .init(name_en: "Subcategory 4.1", name_ru: "Подкатегория 4.1"), currentName: "Subcategory 4.1", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: false, isSubcategory: true, parentId: "id", subcategories: [])
    ]),
    Category(id: UUID().uuidString, names: .init(name_en: "Category 5", name_ru: "Категория 5"), currentName: "Category 5", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: true, isSubcategory: false, parentId: "", subcategories: [
        Category(id: UUID().uuidString, names: .init(name_en: "Subcategory 5.1", name_ru: "Подкатегория 5.1"), currentName: "Subcategory 5.1", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: false, isSubcategory: true, parentId: "id", subcategories: []),
        Category(id: UUID().uuidString, names: .init(name_en: "Subcategory 5.2", name_ru: "Подкатегория 5.2"), currentName: "Subcategory 5.2", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: false, isSubcategory: true, parentId: "id", subcategories: []),
    ]),
    Category(id: UUID().uuidString, names: .init(name_en: "Category 6", name_ru: "Категория 6"), currentName: "Category 6", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: true, isSubcategory: false, parentId: "", subcategories: [
        Category(id: UUID().uuidString, names: .init(name_en: "Subcategory 6.1", name_ru: "Подкатегория 6.1"), currentName: "Subcategory 6.1", icon: "", color: .init(red: 0.41, green: 0.4, blue: 0.124), show: true, isParent: false, isSubcategory: true, parentId: "id", subcategories: [])
    ]),
    
]



struct CategoriesView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject private var addRecord: AddRecordViewModel
    @EnvironmentObject private var store: AppStore<AppState>
    
    @SwiftUI.State private var searchText: String = ""
    @SwiftUI.State private var showSubcategories: Bool = false
    @SwiftUI.State private var tappedParentCategory: Category? = nil
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .top) {
                
                Color("primaryBg").edgesIgnoringSafeArea(.all)
                
                NavigationLink(
                    destination: SubcategoriesView(category: tappedParentCategory ?? Category.example,
                                                   presentation: presentation),
                    isActive: $showSubcategories) { EmptyView() }
                
                VStack {
                    
                    SearchBar(searchText: $searchText)
                    
                    
                    ScrollView {
                        
                        let categories = store.state.user.categories
                        
                        let categoriesEmpty = categories.isEmpty
                        let hideCategories = categories.allSatisfy{( !$0.show )}
                        let searchedCategoriesEmpty = categories.filter({$0.currentName.lowercased().contains(searchText.lowercased()) || searchText.isEmpty}).isEmpty
                        
                        let searchedCategories = categories.filter({$0.currentName.lowercased().contains(searchText.lowercased()) || searchText.isEmpty})
                        
                        if categoriesEmpty || hideCategories || searchedCategoriesEmpty {
                            
                            LazyVStack(alignment: .center, spacing: 20) {
                                Text("There are no such categories")
                                    .nunitoFont(size: 20, weight: .bold, color: .mcGrayText)
                                
                                Button(action: {}) {
                                    Text("Add new category")
                                        .nunitoFont(size: 18, weight: .bold, color: .white)
                                        .padding(10)
                                        .background(Color.mcGreen)
                                        .cornerRadius(10)
                                }
                            }
                            
                        } else {
                            
                            VStack(spacing: 10) {
                                
                                ForEach(searchedCategories) { category in
                                    
                                    Button(action: {
                                        
                                        if category.isParent && !category.subcategories.isEmpty {
                                            self.tappedParentCategory = category
                                            self.showSubcategories.toggle()
                                        } else {
                                            self.addRecord.chosenCategory = category
                                            self.addRecord.isCategoryChosen = true
                                            presentation.wrappedValue.dismiss()
                                        }
                                        
                                    }) {
                                        
                                        CategoryView(category: category, showChildren: true)
                                        
                                    }
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                            .padding(.top, 5)
                            
                        }
                    }
                }
                
                
            }
            .navigationBarTitle("Categories", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {}) {
                                        Image(systemName: "plus")
                                            .foregroundColor(.mcGreen)
                                    }
            )
            
        }
        .navigationBarBackgroundColor(Color("primaryBg"))
        .simultaneousGesture(
            DragGesture().onChanged({ (value) in
                if value.translation.height > 0 {
                    self.hideKeyboard()
                }
            })
        )
        
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
