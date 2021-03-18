//
//  SearchBar.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 29.01.21.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var searchText: String
    
    typealias UIViewType = UISearchBar
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchbar = UISearchBar(frame: .zero)
        searchbar.delegate = context.coordinator
        searchbar.placeholder = "Search"
        searchbar.searchBarStyle = .minimal
        return searchbar
    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchText: $searchText)
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchText
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchText: String
        
        init(searchText: Binding<String>) {
            self._searchText = searchText
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.searchText = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            UIApplication.shared.windows.first{$0.isKeyWindow}?.endEditing(true)
        }
    }
    
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("Some search text"))
    }
}
