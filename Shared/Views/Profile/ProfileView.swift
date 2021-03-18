//
//  ProfileView.swift
//  moneycheck
//
//  Created by Yurij Goose on 22.01.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var store: AppStore<AppState>
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color("primaryBg").edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    HStack {
                        
                        Group {
//                            if let url = URL(string: store.state.user.photoURL) {
                                WebImage(url: URL(string: store.state.user.photoURL))
                                    .resizable()
                                    .placeholder {
                                        Circle().fill(Color.gray)
                                    }
                                    .indicator(.activity)
//                                Image(systemName: "person")
//                                    .data(url: url)
//                                    .resizable()
//                            } else {
//                                Image(systemName: "person")
//                                    .resizable()
//                            }
//                            }
                        }
                        .aspectRatio(contentMode: .fit)
                        .background(Circle().fill(Color.mcGray))
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                    }
                    
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: Text("")) {
                                        Image(systemName: "gear")
                                            .foregroundColor(.mcGreen)
                                            .scaleEffect(1.2)
                                    }
            )
            
        }
        .navigationBarBackgroundColor(Color("primaryBg"))
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
