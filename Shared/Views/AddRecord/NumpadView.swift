//
//  NumpadView.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 25.01.21.
//

import SwiftUI

struct NumpadView: View {
    
    @EnvironmentObject private var addRecord: AddRecordViewModel
    @GestureState private var translation: CGFloat = 0
    
    private let spacing: CGFloat = 12
    private let padding: CGFloat = 20
    
    var body: some View {
        VStack(spacing: spacing) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.mcGray)
                .frame(width: 60, height: 4)
                .offset(y: -10)
            
            HStack(spacing: spacing) {
                ForEach(0..<addRecord.toolBarButtons.count) { k in
                    let button = addRecord.toolBarButtons[k]
                    Button(action: {
                        addRecord.buttonTapped(button: button)
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
            
            ForEach(0..<addRecord.buttons.count, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(0..<addRecord.buttons[row].count, id: \.self) { k in
                        let button = addRecord.buttons[row][k]
                        Button(action: {
                            addRecord.buttonTapped(button: button)
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
                
                if value.startLocation.y < 200 && value.translation.height >= 0 {
                    state = value.translation.height
                }
                
            }
            .onEnded({ (value) in
                if value.translation.height > 150 {
                    withAnimation {
                        self.addRecord.showNumpad = false
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

struct NumpadView_Previews: PreviewProvider {
    static var previews: some View {
        NumpadView()
    }
}
