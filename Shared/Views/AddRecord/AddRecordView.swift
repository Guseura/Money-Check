//
//  AddRecordView.swift
//  moneycheck
//
//  Created by Yurij Goose on 22.01.21.
//

import SwiftUI
import Combine



struct AddRecordView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject private var store: AppStore<AppState>
    
    @StateObject private var addRecord = AddRecordViewModel()
    
    @SwiftUI.State var note = ""
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Color("primaryBg").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                AddRecordTitleView()
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        VStack(spacing: 20) {
                            
                            Picker(selection: $addRecord.transactionType.animation(.easeInOut), label: Text("Picker")) {
                                Text("Expense").tag(0)
                                Text("Income").tag(1)
                                Text("Transfer").tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            
                            AddRecordAmountView()
                                .environmentObject(addRecord)
                            
                        }
                        
                        
                        VStack(spacing: 10) {
                            
                            Button(action: {
                                addRecord.showAccounts.toggle()
                            }) {
                                AddRecordChooseButton(isChosen: $addRecord.isAccountChosen, title: "Account", itemName: addRecord.chosenAccount?.name ?? "", itemIcon: addRecord.chosenAccount?.type.icon ?? "")
                                    .sheet(isPresented: $addRecord.showAccounts) {
                                        AccountsView(isDest: false)
                                            .environmentObject(store)
                                            .environmentObject(addRecord)
                                    }
                            }
                            
                            if addRecord.transactionType == 2 {
                                
                                Button(action: {
                                    addRecord.showDestAccounts.toggle()
                                }) {
                                    AddRecordChooseButton(isChosen: $addRecord.isDestAccountChosen, title: "To account", itemName: addRecord.chosenDestAccount?.name ?? "", itemIcon: addRecord.chosenDestAccount?.type.icon ?? "")
                                        .sheet(isPresented: $addRecord.showDestAccounts) {
                                            AccountsView(isDest: true)
                                                .environmentObject(store)
                                                .environmentObject(addRecord)
                                        }
                                }
                                
                            } else {
                                
                                Button(action: {
                                    addRecord.showCategories.toggle()
                                }) {
                                    AddRecordChooseButton(isChosen: $addRecord.isCategoryChosen, title: "Category", itemName: addRecord.chosenCategory?.names?.name_en ?? "", itemIcon: addRecord.chosenCategory?.icon ?? "")
                                        .sheet(isPresented: $addRecord.showCategories) {
                                            CategoriesView()
                                                .environmentObject(addRecord)
                                        }
                                }
                                
                            }
                            
                            
                            
                            HStack(spacing: 10) {
                                Image(systemName: "calendar.badge.clock")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(.mcGray)
                                
                                Text("Date")
                                    .nunitoFont(size: 18, weight: .semiBold, color: .mcText)
                                
                                Spacer()
                                
                                DatePicker("", selection: $addRecord.chosenDate)
                                    .accentColor(.mcGreen)
                                
                            }
                            .padding()
                            .frame(height: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("secondaryBg"))
                            )
                            
                            VStack {
                                HStack(spacing: 10) {
                                    Image(systemName: "tag.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(.mcGray)
                                    
                                    Text("Labels")
                                        .nunitoFont(size: 18, weight: .semiBold, color: .mcText)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        addRecord.showLabels.toggle()
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.mcGreen)
                                    }
                                    
                                }
                                
                                if !addRecord.chosenLabels.isEmpty {
                                    
                                    LazyVStack(alignment: .leading, spacing: 10) {
                                        
                                        ForEach(addRecord.chosenLabels.indices, id: \.self) { index in
                                            
                                            HStack {
                                                
                                                ForEach(addRecord.chosenLabels[index].indices, id: \.self) { labelIndex in
                                                    
                                                    var label = addRecord.chosenLabels[index][labelIndex]
                                                    
                                                    let color = Color(red: label.color.red, green: label.color.green, blue: label.color.blue)
                                                    
                                                    HStack(spacing: 10) {
                                                        Text(label.name)
                                                            .nunitoFont(size: 16, weight: .bold, color: color.isLight ? .black : .white)
                                                            .lineLimit(1)
                                                        Image(systemName: "xmark.circle.fill")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 15, height: 15)
                                                            .foregroundColor(.mcGreen)
                                                            .onTapGesture {
                                                                addRecord.chosenLabels[index].remove(at: labelIndex)
                                                                // If the Inside Array is empty removing that also...
                                                                if addRecord.chosenLabels[index].isEmpty{
                                                                    addRecord.chosenLabels.remove(at: index)
                                                                }
                                                            }
                                                    }
                                                    .padding(.horizontal, 5)
                                                    .background(color)
                                                    .cornerRadius(5)
                                                    .overlay(
                                                        GeometryReader { reader -> Color in
                                                            
                                                            // By Using MaxX Parameter We Can determine if its exceeds or not....
                                                            let maxX = reader.frame(in: .global).maxX
                                                            
                                                            // Both Paddings  = 30 + 30 = 60
                                                            // Plus 10 For Extra....
                                                            
                                                            if maxX > UIScreen.main.bounds.width - 60 && !label.isExceeded {
                                                                
                                                                label.isExceeded = true
                                                                
                                                                addRecord.chosenLabels.append([label])
                                                                addRecord.chosenLabels[index].removeLast()
                                                                
                                                            }
                                                            
                                                            return .clear
                                                        }
                                                    )
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            .padding()
                            .frame(minHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("secondaryBg"))
                            )
                            
                            .sheet(isPresented: $addRecord.showLabels) {
                                LabelsView()
                                    .environmentObject(addRecord)
                            }
                            
                            Button(action: {
                                addRecord.showNoteField.toggle()
                            }) {

                                HStack(spacing: 10) {
                                    Image(systemName: "note.text.badge.plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(.mcGray)

                                    Text("Note")
                                        .nunitoFont(size: 18, weight: .semiBold, color: .mcText)

                                    Spacer()
                                    
                                    Text(addRecord.note)
                                        .nunitoFont(size: 16, weight: .semiBold, color: .mcGray)
                                    
                                    Image(systemName: "chevron.right")
                                        .nunitoFont(size: 16, weight: .regular, color: .mcGray)

                                }
                                .padding()
                                .frame(height: 60)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("secondaryBg"))
                                )
                                .sheet(isPresented: $addRecord.showNoteField) {
                                    NoteView()
                                        .environmentObject(addRecord)
                                }
                            }
                            
                            
                            
                        }
                        
                    }
                    
                    
                    Spacer()
                    
                    
                    
                }
                .simultaneousGesture(
                    DragGesture().onChanged() {_ in
                        withAnimation {
                            self.addRecord.showNumpad = false
                        }
                    }
                )
                
                
                
                HStack {
                    let disabled = (addRecord.transactionType == 2 ? !addRecord.isDestAccountChosen : !addRecord.isCategoryChosen) || !addRecord.isAccountChosen || addRecord.enteredValue == ""
                    
                    Button(action: { createTransactionHadler() }) {
                        Text("Save")
                            .nunitoFont(size: 18, weight: .extraBold, color: .mcGreen)
                            .padding(.horizontal, 15)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("secondaryBg"))
                            )
                    }
                    .disabled(disabled)
                    .opacity(disabled ? 0.6 : 1)
                }
                .padding(.top, 15)
                .padding(.bottom, getSafeAreaBottom())
                
            }
            .padding(.horizontal)
            
            
            if addRecord.showNumpad {
                NumpadView()
                    .environmentObject(addRecord)
                    .transition(.move(edge: .bottom))
            }
            
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
    
    func createTransactionHadler() {
        
        print(addRecord.isAllowed())
        if addRecord.isAllowed() {
            
            let transaction = addRecord.createTransaction()
            
            store.dispatch(.user(.addTransaction(transaction: transaction)))
         
            presentation.wrappedValue.dismiss()
        }
    }
    
}

struct AddRecordView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddRecordView()
                .preferredColorScheme(.light)
            AddRecordView()
                .preferredColorScheme(.dark)
        }
    }
}



struct AddRecordChooseButton: View {
    
    @Binding var isChosen: Bool
    let title: String
    let itemName: String
    let itemIcon: String
    
    var body: some View {
        HStack(spacing: 10) {
            
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.mcGray)
            
            Text(title)
                .nunitoFont(size: 18, weight: .semiBold, color: .mcText)
            
            Spacer()
            
            Text(isChosen ? itemName
                    : "Required")
                .nunitoFont(size: 16, weight: .semiBold, color: isChosen ? .mcGray : .mcRed)
            
            Image(systemName: "chevron.right")
                .nunitoFont(size: 16, weight: .regular, color: .mcGray)
        }
        .padding()
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("secondaryBg"))
        )
    }
}

extension Color {
    var isLight: Bool {
        guard let components = cgColor?.components else { return false }
        let redBrightness = components[0] * 299
        let greenBrightness = components[1] * 587
        let blueBrightness = components[2] * 114
        let brightness = (redBrightness + greenBrightness + blueBrightness) / 1000
        return brightness > 0.5
    }
}

struct AddRecordTitleView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        HStack {
            Button("Cancel") {
                self.presentation.wrappedValue.dismiss()
            }
            .nunitoFont(size: 18, weight: .semiBold, color: .mcGray)
            Spacer()
            Text("New record")
                .nunitoFont(size: 18, weight: .bold, color: .mcText)
            Spacer()
            Spacer()
        }
        .padding(.vertical)
    }
}

struct AddRecordAmountView: View {
    
    @EnvironmentObject private var addRecord: AddRecordViewModel
    
    var body: some View {
        
        HStack(spacing: 5) {
            Button(action: {}) {
                Text("EUR")
                    .nunitoFont(size: 18, weight: .bold, color: .white)
            }
            .padding(5)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
                Text(addRecord.calcucationText)
                    .nunitoFont(size: 35, weight: .bold, color: .white)
                    .minimumScaleFactor(0.45)
                    .lineLimit(1)
                    .animation(.interactiveSpring())
                
                Spacer()
                
                if addRecord.enteredValue != "" {
                    Text(addRecord.enteredValue)
                        .nunitoFont(size: 14, weight: .semiBold, color: .mcGrayText)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                        .animation(.interactiveSpring())
                }
                
            }
            .frame(height: 50)
        }
        .frame(height: 50)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(addRecord.transactionType == 0 ? Color.mcRed : addRecord.transactionType == 1 ? Color.mcGreen : Color.mcGray)
        )
        .onTapGesture {
            withAnimation {
                self.addRecord.showNumpad = true
            }
        }
    }
}
