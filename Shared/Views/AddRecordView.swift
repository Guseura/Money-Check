//
//  AddRecordView.swift
//  moneycheck
//
//  Created by Yurij Goose on 22.01.21.
//

import SwiftUI
import Combine



struct AddRecordView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @StateObject private var recordModel = AddRecordViewModel()
    
    @SwiftUI.State private var transactionType = 0
    
    @SwiftUI.State private var showNumpad = true
//
//    var formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 2
//        formatter.minimum = 0
//        return formatter
//    }()
    
    init() {
        
        UISegmentedControl.appearance().backgroundColor = UIColor(named: "secondaryBg")
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "primaryBg")
        
        //        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont(name: "Nunito-SemiBold", size: 16)!], for: .normal)
        //        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont(name: "Nunito-Bold", size: 16)!, .foregroundColor: UIColor(.mcGreen)], for: .selected)
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Color("primaryBg").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Button("Cancel") {
                        self.presentation.wrappedValue.dismiss()
                    }
                    .nunitoFont(size: 18, weight: .semiBold, color: .mcGray)
                    Spacer()
                    Text("New record")
                        .nunitoFont(size: 18, weight: .bold, color: .mcText)
                    Spacer()
                    Spacer()
                }
                .padding(.vertical)
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        Picker(selection: $transactionType, label: Text("Picker")) {
                            Text("Expense").tag(0)
                            Text("Income").tag(1)
                            Text("Transfer").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        
                        VStack {
                            HStack {
                                
                                Button(action: {}) {
                                    Text("EUR")
                                        .nunitoFont(size: 18, weight: .bold, color: .mcText)
                                }
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 7)
                                        .fill(Color("secondaryBg"))
                                )
                                Spacer()
                                Text(recordModel.calcucationText)
                                    .nunitoFont(size: 35, weight: .bold, color: .white)
                                    .multilineTextAlignment(.trailing)
                                    .minimumScaleFactor(0.4)
                                    .lineLimit(1)
                            }
                            HStack {
                                Spacer()
                                Text(recordModel.enteredValue)
                                    .nunitoFont(size: 14, weight: .semiBold, color: .mcGrayText)
                                    .multilineTextAlignment(.trailing)
                                    .lineLimit(1)
                            }

                        }
                        .frame(height: 50)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(transactionType == 0 ? Color.mcRed : transactionType == 1 ? Color.mcGreen : Color.mcGray)
                        )
                        .onTapGesture {
                            withAnimation {
                                self.showNumpad = true
                            }
                        }
                        
                    }
                    
                    Spacer()
                    
                    
                    
                }
                
                
                HStack {
                    Button(action: {}) {
                        Text("Save")
                            .nunitoFont(size: 18, weight: .extraBold, color: .mcGreen)
                            .padding(.horizontal, 15)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("secondaryBg"))
                            )
                    }
                }
                .padding(.top, 15)
                .padding(.bottom, getSafeAreaBottom())
                
            }
            .padding(.horizontal)
            
            
            if showNumpad {
                NumpadView(show: $showNumpad)
                    .environmentObject(recordModel)
                    .transition(.move(edge: .bottom))
            }
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
    
}

struct AddRecordView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddRecordView()
                .preferredColorScheme(.light)
            AddRecordView()
                .preferredColorScheme(.dark)
        }
    }
}

struct NumpadView: View {
    
    @EnvironmentObject private var recordModel: AddRecordViewModel
    @GestureState private var translation: CGFloat = 0
    @Binding var show: Bool
    
    private let spacing: CGFloat = 12
    private let padding: CGFloat = 20
    
    var body: some View {
        VStack(spacing: spacing) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.mcGray)
                .frame(width: 60, height: 4)
                .offset(y: -10)
            
            HStack(spacing: spacing) {
                ForEach(0..<recordModel.toolBarButtons.count) { k in
                    let button = recordModel.toolBarButtons[k]
                    Button(action: {
                        recordModel.buttonTapped(button: button)
                    }) {
                        Image(systemName: button.type.title)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.mcGreen)
                            .frame(width: getButtonSize(for: button), height: getButtonSize(for: button)/2)
                            .background(Color("secondaryBg"))
                            .cornerRadius(10)
                    }
                }
            }
            
            ForEach(0..<recordModel.buttons.count, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(0..<recordModel.buttons[row].count, id: \.self) { k in
                        let button = recordModel.buttons[row][k]
                        Button(action: {
                            recordModel.buttonTapped(button: button)
                        }) {
                            Group {
                                
                                switch button.type {
                                case .operation, .delete:
                                    Image(systemName: button.type.title)
                                        .font(.system(size: 25, weight: .bold))
                                        .foregroundColor(.mcGreen)
                                default:
                                    Text(button.type.title)
                                        .nunitoFont(size: 20, weight: .bold, color: .mcText)
                                }

                            }
                            .frame(width: getButtonSize(for: button),
                                   height: getButtonSize(for: button)/2)
                            .background(Color("secondaryBg"))
                            .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .padding(padding)
        .padding(.bottom, getSafeAreaBottom() != 0 ? getSafeAreaBottom() : padding)
        .background(
            RoundedCorner(radius: 25, corners: [.topLeft, .topRight])
                .fill(Color("primaryBg"))
                .shadow(color: .mcShadow, radius: 15, x: 0, y: 1)
        )
        .offset(y: translation)
        .animation(.interactiveSpring())
        .gesture(
            DragGesture().updating(self.$translation) { value, state, _ in
                
                if value.startLocation.y < 100 && value.translation.height >= 0 {
                    state = value.translation.height
                }
                
            }
            .onEnded({ (value) in
                if value.translation.height > 150 {
                    withAnimation {
                        self.show = false
                    }
                }
            })
        )
    }
    
    func getButtonSize(for button: NumpadButton) -> CGFloat {
        
        switch button.type {
        
        case .operation:
            return (UIScreen.main.bounds.width - 2 * padding - 3 * spacing) / 4
        default:
            return (UIScreen.main.bounds.width - 2 * padding - 2 * spacing) / 3
        }
        
    }
    
}


