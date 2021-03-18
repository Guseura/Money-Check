//
//  AccountView.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 27.01.21.
//

import SwiftUI

struct AccountView: View {
    
    let account: Account
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            if account.type.icon == "" {
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.mcGray)
            } else {
                Image(account.type.icon)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.mcGray)
                    .background(Color(red: account.color.red, green: account.color.green, blue: account.color.blue))
            }
            
            
            Text(account.name)
                .nunitoFont(size: 18, weight: .semiBold, color: .mcText)
            
            Spacer()
            
        }
        .padding()
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("secondaryBg"))
        )
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(account: Account.example)
    }
}
