//
//  ContentView.swift
//  Rectangle Progress Bar
//
//  Created by Vir Shah on 7/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var topProgress: CGFloat = 10
    @State var rightProgress: CGFloat = 0
    @State var leftProgress: CGFloat = 0
    @State var bottomProgress: CGFloat = 0
    @State var firstRun = true // commits timer once
    @State var running = true
    var timer = Timer.publish(every: 0.005, on: .main, in: .common)

    var body: some View {
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            let maxHeight = geometry.size.height

            RectangularProgressBar(topProgress: topProgress, rightProgress: rightProgress, leftProgress: leftProgress, bottomProgress: bottomProgress, maxHeight: maxHeight, maxWidth: maxWidth)
                .onReceive(timer) { _ in
                    if running {
                        if topProgress < maxWidth {
                            topProgress += 1
                        } else {
                            if rightProgress < maxHeight {
                                rightProgress += 1
                            } else {
                                if bottomProgress < maxWidth {
                                    bottomProgress += 1
                                } else {
                                    if leftProgress < maxHeight {
                                        leftProgress += 1
                                    }
                                }
                            }
                        }
                    }
                }
                .ignoresSafeArea()

                // button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            if firstRun {
                                _ = timer.connect()
                                firstRun = false
                            }
                            running = true
                        }, label: {
                          Text("Start Progress Bars")
                        })
                        Spacer()
                        Button("Reset") {
                            // resets progress
                            topProgress = 0
                            rightProgress = 0
                            leftProgress = 0
                            bottomProgress = 0
                            // stops progress bar motion
                            running = false
                        }
                        Spacer()
                    }.padding(30)
                }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
