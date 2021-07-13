//
//  StraightLine.swift
//  Bouncing Rectangle Progress Bar
//
//  Created by Vir Shah on 7/12/21.
//

import SwiftUI

struct StraightLine: View {
    let beginning: (CGFloat, CGFloat)
    let ending: (CGFloat, CGFloat)
    let colour: Color
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: beginning.0, y: beginning.1))
            path.addLine(to: CGPoint(x: ending.0, y: ending.1))
            path.closeSubpath()
        }.stroke(colour, lineWidth: 4)
    }
}

struct StraightLine_Previews: PreviewProvider {
    static var previews: some View {
        StraightLine(beginning: (50,100), ending: (100,200), colour: .black)
    }
}
