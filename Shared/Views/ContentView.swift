//
//  ContentView.swift
//  Shared
//
//  Created by Yurij Goose on 25.01.21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: AppStore<AppState>
    @EnvironmentObject var status: StatusViewModel
    
    @SwiftUI.State private var email: String = ""
    @SwiftUI.State private var password: String = ""
    
    @SwiftUI.State var show = false
    
    var body: some View {
        
        ZStack {
            
            if store.state.auth.authenticated {
                
                HomeView()
                
            } else {

                SignInView()

            }
            
            GeometryReader { geometry in
                
                VStack {
                    
                    if status.showLoading {
                        AlertView(type: .loading, text: "", show: $status.showLoading)
                            .transition(.asymmetric(insertion: .move(edge: .top), removal: .identity))
                            .animation(.easeOut(duration: 0.15))
                    } else if status.showError {
                        AlertView(type: .error, text: status.error ?? "", show: $status.showError)
                            .transition(.asymmetric(insertion: .identity, removal: .move(edge: .top)))
                            .animation(.easeOut(duration: 0.15))
                    } else if status.showSuccess {
                        AlertView(type: .success, text: status.success ?? "", show: $status.showSuccess)
                            .transition(.asymmetric(insertion: .identity, removal: .move(edge: .top)))
                            .animation(.easeOut(duration: 0.15))
                    }
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                
            }
            .background(
                Rectangle()
                    .fill(Color.black.opacity( status.showLoading ? 0.2 : 0))
                    .edgesIgnoringSafeArea(.all)
            )
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppStore<AppState>(initState: .init(user: UserState(), auth: AuthState()), reducer: appReducer, middlewares: [appMiddleware(), authMiddleware(), userMiddleware()], status: StatusViewModel()))
    }
}
