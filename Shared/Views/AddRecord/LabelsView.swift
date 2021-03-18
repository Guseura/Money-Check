//
//  LabelsView.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 29.01.21.
//

import SwiftUI

let labels: [Label] = [
    
    Label(id: UUID().uuidString, name: "Label 13", color: .init(red: 0.13, green: 0.41, blue: 0.62), show: true),
    Label(id: UUID().uuidString, name: "Label 11", color: .init(red: 0.54, green: 0.43, blue: 0.23), show: true),
    Label(id: UUID().uuidString, name: "Label 12", color: .init(red: 0.24, green: 0.44, blue: 0.63), show: true),
    Label(id: UUID().uuidString, name: "Label 51", color: .init(red: 0.23, green: 0.48, blue: 0.24), show: true),
    Label(id: UUID().uuidString, name: "Label 15", color: .init(red: 0.13, green: 0.31, blue: 0.13), show: true),
    Label(id: UUID().uuidString, name: "Label 11", color: .init(red: 0.36, green: 0.71, blue: 0.78), show: true),
    Label(id: UUID().uuidString, name: "Label 74", color: .init(red: 0.83, green: 0.01, blue: 0.85), show: true),
    Label(id: UUID().uuidString, name: "Label 23", color: .init(red: 0.33, green: 0.11, blue: 0.52), show: true),
    Label(id: UUID().uuidString, name: "Label 36", color: .init(red: 0.53, green: 0.51, blue: 0.73), show: true),
    Label(id: UUID().uuidString, name: "Label 94", color: .init(red: 0.93, green: 0.71, blue: 0.93), show: true),
    
]

struct LabelsView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var addRecord: AddRecordViewModel
    
    @EnvironmentObject private var store: AppStore<AppState>
    
    @SwiftUI.State private var searchText: String = ""
    
    var body: some View {
        
        
        NavigationView {
            
            ZStack(alignment: .top) {
                
                Color("primaryBg").edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    SearchBar(searchText: $searchText)
                    
                    let labels = store.state.user.labels
                    
                    let hideLabels = labels.allSatisfy{( !$0.show )}
                    
                    let searchedLabelsEmpty = labels.filter({$0.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty}).isEmpty
                    
                    let labelsEmpty = labels.isEmpty
                    
                    let searchedLabels = labels.filter({$0.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty})
                    
                    
                    
                    ScrollView {
                        
                        if hideLabels || labelsEmpty || searchedLabelsEmpty {
                            
                            VStack(spacing: 20) {
                                Text("There are no such labels")
                                    .nunitoFont(size: 20, weight: .bold, color: .mcGrayText)
                                
                                Button(action: {}) {
                                    Text("Add new label")
                                        .nunitoFont(size: 18, weight: .bold, color: .white)
                                        .padding(10)
                                        .background(Color.mcGreen)
                                        .cornerRadius(10)
                                }
                            }
                            
                        } else {
                            
                            VStack(spacing: 10) {
                                
                                ForEach(searchedLabels) { label in
                                    
                                    Button(action: {
                                        if !addRecord.chosenLabels.contains(where: {$0.contains(where: {$0.id == label.id})}) {
                                            if self.addRecord.chosenLabels.isEmpty {
                                                self.addRecord.chosenLabels.append([])
                                            }
                                            self.addRecord.chosenLabels[addRecord.chosenLabels.count - 1].append(label)
                                        }
                                        presentation.wrappedValue.dismiss()
                                    }) {
                                        LabelView(label: label)
                                    }
                                    .disabled(addRecord.chosenLabels.contains(where: {$0.contains(where: {$0.id == label.id})}))
                                    .opacity(addRecord.chosenLabels.contains(where: {$0.contains(where: {$0.id == label.id})}) ? 0.45 : 1)
                                }
                                
                            }
                            .padding(.horizontal)
                            .padding(.top, 5)
                            
                            
                        }
                        
                        
                    }
                    
                }
                
            }
            .navigationBarTitle("Accounts", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {}) {
                                        Image(systemName: "plus")
                                            .foregroundColor(.mcGreen)
                                    }
            )
        }
        .navigationBarBackgroundColor(Color("primaryBg"))
        .gesture(
            DragGesture().onChanged({ (value) in
                if value.translation.height > 0 {
                    self.hideKeyboard()
                }
            })
        )
        
        
    }
}

struct LabelsView_Previews: PreviewProvider {
    static var previews: some View {
        LabelsView()
    }
}
