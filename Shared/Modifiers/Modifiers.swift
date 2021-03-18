//
//  Modifiers.swift
//  moneycheck
//
//  Created by Yurij Goose on 15.01.21.
//

import Foundation
import SwiftUI

enum NunitoFontWeight {
    case extraLight, light, regular, semiBold, bold, extraBold, black
}

struct NunitoFontModifier: ViewModifier {
    
    var size: CGFloat
    var weight: NunitoFontWeight
    var color: Color
    
    var name: String {
        switch weight {
        case .extraLight:
            return "Nunito-ExtraLight"
        case .light:
            return "Nunito-Light"
        case .regular:
            return "Nunito-Regular"
        case .semiBold:
            return "Nunito-SemiBold"
        case .bold:
            return "Nunito-Bold"
        case .extraBold:
            return "Nunito-ExtraBold"
        case .black:
            return "Nunito-Black"
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(name, size: size))
            .foregroundColor(color)
    }
    
}

struct NavigationBarBackgroundColor: ViewModifier {
    
    let backgroundColor: Color
    
    init(backgroundColor: Color) {
        self.backgroundColor = backgroundColor
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(backgroundColor)

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
        }
        return self
    }
}

extension View {
    func nunitoFont(size: CGFloat, weight: NunitoFontWeight, color: Color) -> some View {
        self.modifier(NunitoFontModifier(size: size, weight: weight, color: color))
    }
    
    func customCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func navigationBarBackgroundColor(_ backgroundColor: Color) -> some View {
        self.modifier(NavigationBarBackgroundColor(backgroundColor: backgroundColor))
    }
    
    func hideKeyboard() {
        UIApplication.shared.windows.first{$0.isKeyWindow}?.endEditing(true)
    }
}

