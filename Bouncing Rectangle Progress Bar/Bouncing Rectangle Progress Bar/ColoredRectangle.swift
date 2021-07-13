//
//  ColoredRectangle.swift
//  Bouncing Rectangle Progress Bar
//
//  Created by Vir Shah on 7/12/21.
//

import SwiftUI

struct ColoredRectangle: View {
    var body: some View {
        ZStack {
            StraightLine(beginning: (0, 0), ending: (0, 100), colour: .blue) // left
            StraightLine(beginning: (0,100), ending: (100,100), colour: .yellow) // bottom
            StraightLine(beginning: (100, 100), ending: (100, 0), colour: .red) // right
            StraightLine(beginning: (100, 0), ending: (0, 0), colour: .red) // top
        }
    }
}

struct ColoredRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColoredRectangle()
    }
}
