//
//  CircularImageModifier.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 16/05/22.
//

import SwiftUI

struct OverlayModifier:ViewModifier {
    
    let radius:CGFloat
    let lineWidth:CGFloat
    let color:Color
    
    func body(content: Content) -> some View {
            content
            .overlay(RoundedRectangle(cornerRadius: radius).stroke(color,lineWidth: lineWidth))
        }
}

extension View {
    func addOverlay(radius:CGFloat, lineWidth:CGFloat = 1.0, color:Color = AppColor.black) -> some View {
        return self.modifier(OverlayModifier(radius: radius, lineWidth: lineWidth, color: color))
    }
}
