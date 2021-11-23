//
//  Cardify.swift
//  Memorize
//
//  Created by Jordi Dewit on 23/11/2021.
//  wraps a card around a view (viewmodifier)

import Foundation
import SwiftUI

struct Cardify: AnimatableModifier{
    var rotation: Double
    
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack // Puts all elements on top of eachother inside the zstack container
        {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius) //you use let when you are defining a constant
            
            if rotation < 90{
                shape
                    .fill() // creating a white background
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: DrawingConstants.linewidth) //border with a width of 3px
                
             }else{
                shape.fill()
             }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat  = 15
        static let linewidth: CGFloat     = 3
        static let fontScale: CGFloat     = 0.65
        static let circlePadding: CGFloat = 2
    }
    
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }

}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
