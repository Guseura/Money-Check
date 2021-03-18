//
//  Constants.swift
//  moneycheck
//
//  Created by Yurij Goose on 15.01.21.
//

import Foundation
import SwiftUI
import Combine

extension UIApplication {
    var isKeyboardPresented: Bool {
        guard let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow") else {
            return false
        }
        return UIApplication.shared.windows.contains(where: { $0.isKind(of: keyboardWindowClass) })
    }
}

func hapticFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
}

extension Color {
    
    public static var mcGreen: Color {
        return Color("green")
    }
    
    public static var mcRed: Color {
        return Color("red")
    }
    
    public static var mcGray: Color {
        return Color("gray")
    }
    
    public static var mcPrimaryBg: Color {
        return Color("primaryBg")
    }
    
    public static var mcShadow: Color {
        return Color("shadow")
    }
    
    public static var mcText: Color {
        return Color("text")
    }
    
    public static var mcGrayText: Color {
        return Color("grayText")
    }
    
}

enum Device {
    case iPhone, iPad, macOS
}

func getDevice() -> Device {
    #if os(iOS)
    // Since There is No Direct For Getting iPad OS...
    // Alternative Way...
    if UIDevice.current.model.contains("iPad"){
        return .iPad
    }
    else{
        return .iPhone
    }
    #else
    return .macOS
    #endif
}

enum DeviceOrientation {
    case landscape, portrait
}

func getOrientation() -> DeviceOrientation {
    
    #if os(iOS)
    if UIDevice.current.model.contains("iPad"){
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            return .landscape
        } else {
            return .portrait
        }
        
    }
    else{
        return .portrait
    }
    #endif
    
}

