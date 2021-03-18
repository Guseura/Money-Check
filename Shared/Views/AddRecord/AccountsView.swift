//
//  AccountsView.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 27.01.21.
//

import SwiftUI

let accounts: [Account] = [
    
//    Account(id: UUID().uuidString, name: "Business", type: .init(name: "General", icon: ""), currency: "EUR", color: .init(red: 0.123, green: 0.41, blue: 0.12), currentBalance: 500, show: true),
//    Account(id: UUID().uuidString, name: "Cash", type: .init(name: "Cash", icon: ""), currency: "USD", color: .init(red: 0.123, green: 0.41, blue: 0.12), currentBalance: 5000, show: true),
//    Account(id: UUID().uuidString, name: "Bank", type: .init(name: "Bank", icon: ""), currency: "UAH", color: .init(red: 0.123, green: 0.41, blue: 0.12), currentBalance: 42483, show: true),
//    Account(id: UUID().uuidString, name: "Savings", type: .init(name: "Deposit", icon: ""), currency: "USD", color: .init(red: 0.123, green: 0.41, blue: 0.12), currentBalance: 19837, show: true),
//    Account(id: UUID().uuidString, name: "Bank 2", type: .init(name: "Bank", icon: ""), currency: "EUR", color: .init(red: 0.123, green: 0.41, blue: 0.12), currentBalance: 123, show: true),
]

struct AccountsView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject private var addRecord: AddRecordViewModel
    @EnvironmentObject private var store: AppStore<AppState>
    
    @SwiftUI.State private var searchText: String = ""
    
    var isDest: Bool

    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .top) {
                
                Color("primaryBg").edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    SearchBar(searchText: $searchText)
                    
                    
                    ScrollView {
                        
                        let isTransfer = addRecord.transactionType == 2
                        
                        let accounts = store.state.user.accounts
                        let accountsEmpty = accounts.isEmpty
                        
                        let hideAccounts = isTransfer ? false : accounts.allSatisfy({ !$0.show })
                        
                        let showTransferAccount = (isDest ? addRecord.chosenAccount != Account.transfer : addRecord.chosenDestAccount != Account.transfer) && (searchText.isEmpty ? true : Account.transfer.name.lowercased().contains(searchText.lowercased())) && isTransfer
                        
                        let hideTransferAccount = isTransfer ? !showTransferAccount : false
                        
                        let searchedAccountsEmpty = accounts.filter({$0.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty}).isEmpty
                    
                        let searchedAccount = accounts.filter({ $0.show && $0.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty})
                        
                        
                        if accountsEmpty || hideAccounts || searchedAccountsEmpty && hideTransferAccount {
                            
                            LazyVStack(alignment: .center, spacing: 20) {
                                Text("There are no such accounts")
                                    .nunitoFont(size: 20, weight: .bold, color: .mcGrayText)
                                
                                Button(action: {}) {
                                    Text("Add new account")
                                        .nunitoFont(size: 18, weight: .bold, color: .white)
                                        .padding(10)
                                        .background(Color.mcGreen)
                                        .cornerRadius(10)
                                }
                            }
                            
                        } else {
                            
                            VStack(spacing: 10) {
                                
                                
                                ForEach(searchedAccount) { account in
                                    
                                    if isDest ? addRecord.chosenAccount != account : addRecord.chosenDestAccount != account {
                                        
                                        Button(action: {
                                            
                                            if isDest {
                                                self.addRecord.chosenDestAccount = account
                                                self.addRecord.isDestAccountChosen = true
                                            } else {
                                                self.addRecord.chosenAccount = account
                                                self.addRecord.isAccountChosen = true
                                            }
                                            presentation.wrappedValue.dismiss()
                                        }) {
                                            AccountView(account: account)
                                        }
                                        
                                    }
                                    
                                }
                                
                                if showTransferAccount {
                                    
                                    Button(action: {
                                        if isDest {
                                            self.addRecord.chosenDestAccount = Account.transfer
                                            self.addRecord.isDestAccountChosen = true
                                        } else {
                                            self.addRecord.chosenAccount = Account.transfer
                                            self.addRecord.isAccountChosen = true
                                        }
                                        presentation.wrappedValue.dismiss()
                                    }) {
                                        AccountView(account: Account.transfer)
                                    }
                                    
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
            DragGesture().onChanged({ value in
                if UIApplication.shared.isKeyboardPresented {
                    if value.translation.height > 0 {
                        self.hideKeyboard()
                    }
                }
            })
        )
        
    }
}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView(isDest: false).preferredColorScheme(.dark)
        
    }
}
