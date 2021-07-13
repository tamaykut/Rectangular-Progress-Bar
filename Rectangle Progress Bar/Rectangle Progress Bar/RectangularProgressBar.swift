//
//  RectangularProgressBar.swift
//  Rectangle Progress Bar
//
//  Created by Vir Shah on 7/12/21.
//

import SwiftUI

struct RectangularProgressBar: View {
    // values of each progress bar
    var topProgress: CGFloat
    var rightProgress: CGFloat
    var leftProgress: CGFloat
    var bottomProgress: CGFloat
    
    // screen size values
    var maxHeight: CGFloat
    var maxWidth: CGFloat
    
    let barSize: CGFloat = 20 // width of each progress bar
    
    var body: some View {
        ZStack {
            // left
            HStack {
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .frame(width: barSize, height: maxHeight)
                    Rectangle()
                        .frame(width: barSize, height: leftProgress)
                        .foregroundColor(.blue)
                }
                Spacer()
            }

            // bottom
            VStack {
                Spacer()
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: maxWidth, height: barSize)

                    Rectangle()
                        .frame(width: bottomProgress, height: barSize)
                        .foregroundColor(.blue)
                }
            }

            // right side
            HStack {
                Spacer()
                ZStack(alignment: .top) {
                    Rectangle()
                        .frame(width: barSize, height: maxHeight)
                    Rectangle()
                        .frame(width: barSize, height: rightProgress)
                        .foregroundColor(.blue)
                }
            }
            
            // top
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: maxWidth, height: barSize)

                    Rectangle()
                        .frame(width: topProgress, height: barSize)
                        .foregroundColor(.blue)
                }
                Spacer()
            }
        }
    }
}

struct RectangularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        RectangularProgressBar(topProgress: CGFloat(10.0), rightProgress: CGFloat(0), leftProgress: CGFloat(0), bottomProgress: CGFloat(0), maxHeight: CGFloat(320), maxWidth: CGFloat(700))
    }
}
