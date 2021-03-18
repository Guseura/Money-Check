//
//  LabelVIEW.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 29.01.21.
//

import SwiftUI

struct LabelView: View {
    
    let label: Label
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: label.color.red, green: label.color.green, blue: label.color.blue))
                .frame(width: 35, height: 35)
            
            Text(label.name)
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

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(label: Label.example)
    }
}
