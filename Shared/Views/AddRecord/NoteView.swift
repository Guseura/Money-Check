//
//  NoteView.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 01.02.21.
//

import SwiftUI

struct NoteView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var addRecord: AddRecordViewModel
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .top) {
                Color("primaryBg").edgesIgnoringSafeArea(.all)
                
                TextField("Enter your note", text: $addRecord.note)
                    .nunitoFont(size: 18, weight: .semiBold, color: .mcText)
                    .padding()
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("secondaryBg"))
                    )
                
            }
            .navigationBarTitle("Note", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button("Cancel") {
                                        presentation.wrappedValue.dismiss()
                                    },
                                trailing:
                                    Button("Save") {
                                        presentation.wrappedValue.dismiss()
                                    }
            )
            
            
        }
        .navigationBarBackgroundColor(Color("primaryBg"))
        
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
