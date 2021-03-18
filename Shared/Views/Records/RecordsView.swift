//
//  Records.swift
//  moneycheck
//
//  Created by Yurij Goose on 22.01.21.
//

import SwiftUI

struct RecordsView: View {
    
    @EnvironmentObject private var store: AppStore<AppState>
    
    let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "dd MMM, yyyy - hh:mm:ss"
    }
    
    var body: some View {
        
        VStack {
            
            ForEach(store.state.user.transactions) { transaction in
                
                VStack {
                    HStack {
                        Text(transaction.type.rawValue)
                        Spacer()
                        Text(String(transaction.amount))
                        Text(transaction.currency)
                    }
                    
                    Text(dateFormatter.string(from: transaction.date.dateValue()))
                    
                }
                
            }
            
        }
        
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView()
    }
}
