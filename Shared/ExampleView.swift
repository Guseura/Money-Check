//
//  ExampleView.swift
//  moneycheck
//
//  Created by Yurij Goose on 20.01.21.
//

import SwiftUI

struct ExampleView: View {
    
    @StateObject private var params = ParamViewModel()
    
    @SwiftUI.State private var modal: Bool = false
    
    var body: some View {
        
        VStack {
            TextField("Weight", text: $params.weight)
            TextField("Weight", text: $params.height)
        }
        .sheet(isPresented: $modal) {
            ModalView()
                .environmentObject(params)
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExampleView()
            ExampleView().colorScheme(.dark)
        }
    }
}

struct ModalView: View {
    
    @EnvironmentObject private var params: ParamViewModel
    
    var body: some View {
        
        Text(params.indexOfWeight)
        
    }
}

class ParamViewModel: ObservableObject {
    
    
    @Published var height: String = ""
    @Published var weight: String = ""
    
    
    var indexOfWeight: String {
        // тут конвертуєш в число і шось вираховуєш і обратно конвертуєш
        return height + weight
    }
    
}
