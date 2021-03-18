//
//  MoneyCheckApp.swift
//  Shared
//
//  Created by Yurij Goose on 25.01.21.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

//        FirebaseApp.configure()

        return true
    }
}

@main
struct MoneyCheckApp: App {
    
    @ObservedObject var status = StatusViewModel()
    @ObservedObject var store = Store(initState: .init(user: UserState(),
                                               auth: AuthState()),
                              reducer: appReducer,
                              middlewares: [
                                appMiddleware(),
                                authMiddleware(),
                                userMiddleware()
                              ],
                              status: StatusViewModel())
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()

        store.status = status

        store.dispatch(.auth(.reducer(.setLoading(loading: true))))

        if let user = Auth.auth().currentUser {
            self.store.dispatch(.user(.getUser(id: user.uid)))
        } else {
            store.dispatch(.auth(.reducer(.setLoading(loading: false))))
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            
            Group {
                
                if store.state.auth.authLoading {
                    
                    ZStack {
                        
                        Color("signInBg").edgesIgnoringSafeArea(.all)
                        
                        VStack(spacing: 20) {
                            
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .mcGreen))
                                .scaleEffect(1.5)
                            
                            Text("Loading")
                                .nunitoFont(size: 20, weight: .bold, color: .mcGray)
                        }
                        
                    }
                    
                    
                    
                } else {
                    
                    ContentView()
                        .environmentObject(store)
                        .environmentObject(status)
                    
                }
                
            }
            
        }
    }
}

import SwiftUI
