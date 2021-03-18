//
//  HomeView.swift
//  moneycheck
//
//  Created by Yurij Goose on 22.01.21.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @SwiftUI.State private var selectedTab = "Dashboard"
    @SwiftUI.State private var showAddRecord = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                
                DashboardView()
                    .tag("Dashboard")
                
                RecordsView()
                    .tag("Records")
                
                StatisticsView()
                    .tag("Statistics")
                
                ProfileView()
                    .tag("Profile")
                
            }
            
            HStack(spacing: 0) {
                
                TabBarButtonView(title: "Dashboard", image: "homeIcon", selectedTab: $selectedTab, showAddRecord: $showAddRecord)
                TabBarButtonView(title: "Records", image: "homeIcon", selectedTab: $selectedTab, showAddRecord: $showAddRecord)
                TabBarButtonView(title: "AddRecord", image: "plusIcon", selectedTab: $selectedTab, showAddRecord: $showAddRecord)
                TabBarButtonView(title: "Statistics", image: "statsIcon", selectedTab: $selectedTab, showAddRecord: $showAddRecord)
                TabBarButtonView(title: "Profile", image: "homeIcon", selectedTab: $selectedTab, showAddRecord: $showAddRecord)

            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedCorner(radius: 25, corners: [.topLeft, .topRight])
                    .fill(Color("secondaryBg"))
                    .shadow(color: .mcShadow, radius: 15, x: 0, y: 1)
            )
            .sheet(isPresented: $showAddRecord) {
                AddRecordView()
            }
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView().preferredColorScheme(.light)
            HomeView().preferredColorScheme(.dark)
        }
    }
}

struct TabBarButtonView: View {
    
    let title: String
    let image: String
    
    @Binding var selectedTab: String
    @Binding var showAddRecord: Bool
    
    var body: some View {
        Button(action: {
            
            if title == "AddRecord" {
                showAddRecord.toggle()
            } else {
                selectedTab = title
            }
        }) {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .frame(maxWidth: 20, maxHeight: 20)
                .aspectRatio(contentMode: .fit)
                .foregroundColor( selectedTab == title ? .mcGreen : .mcGray )
                .padding(.top, 26)
        }
        .frame(width: UIScreen.main.bounds.width / 5, height: 62 + getSafeAreaBottom(), alignment: .top)
        
    }
    
}

extension View {
    
    func getSafeAreaBottom() -> CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.bottom ?? 10
    }
    
}
