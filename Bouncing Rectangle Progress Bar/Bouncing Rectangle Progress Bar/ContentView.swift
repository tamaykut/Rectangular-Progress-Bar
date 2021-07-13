//
//  ContentView.swift
//  Bouncing Rectangle Progress Bar
//
//  Created by Vir Shah on 7/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var x: CGFloat = 0
    @State var y: CGFloat = 0
    @State var timeElapsed: Double = 0
    @State var alreadyConnected = false
    @State var rightReverse = false // moving right and left
    @State var leftReverse = false // moving up and down

    let time: Double = 5 //adjusts length of program
    var actualTimer = Timer.publish(every: 0.1, on: .main, in: .common)
    var timer = Timer.publish(every: 1, on: .main, in: .common)
    var speedTimer = Timer.publish(every: 0.005, on: .main, in: .common)
    
    /* breakdown of timers
     actualTimer = timer that controls rectangle movement
     timer = timer that keeps track of 5 seconds
     speedTimer = controls progress bar
     */

    // initial position/direction
    let randomX = Int.random(in: 20...30)
    let randomY = Int.random(in: 20...30)
    
    // rectangular progress bar variables
    @State var topProgress: CGFloat = 0
    @State var rightProgress: CGFloat = 0
    @State var leftProgress: CGFloat = 0
    @State var bottomProgress: CGFloat = 0
    @State var firstRun = true // commits timer once
    @State var running = true // prevents progress bars from moving without start button pressed

    // main view area
    var body: some View {
        GeometryReader { geometry in
            // getting screen size
            let maxWidth = geometry.size.width/2
            let maxHeight = geometry.size.height/2
            let totalDistance = maxWidth*4 + maxHeight * 4 // permiter
            let iteration = totalDistance / 5 * 0.005
            
            // UI code
            ZStack {
                RectangularProgressBar(topProgress: topProgress, rightProgress: rightProgress, leftProgress: leftProgress, bottomProgress: bottomProgress, maxHeight: maxHeight*2, maxWidth: maxWidth*2)
                    .onReceive(speedTimer) { _ in
                        if running {
                            if topProgress < maxWidth*2 {
                                topProgress += iteration
                            } else {
                                if rightProgress < maxHeight*2 {
                                    rightProgress += iteration
                                } else {
                                    if bottomProgress < maxWidth*2 {
                                        bottomProgress += iteration
                                    } else {
                                        if leftProgress < maxHeight*2 {
                                            leftProgress += iteration
                                        }
                                    }
                                }
                            }
                        }
                    }

                Rectangle()
                    .overlay(ColoredRectangle()) // gives colors
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .offset(x: x, y: y)
                    .animation(.easeInOut(duration:1))
                    .onReceive(timer) { _ in
                        timeElapsed += 1
                    }
                    .onReceive(actualTimer) { _ in
                        // handles rectangle bouncing
                        if time-timeElapsed > 0 {
                            if abs(abs(x) - maxWidth) < 70 {
                                print("Bouncing on Side: (\(x),\(y))")
                                rightReverse = !rightReverse
                            }

                            if abs(abs(y) - maxHeight) < 70 {
                            print("Bouncing on Top/Bottom: (\(x),\(y))")
                                leftReverse = !leftReverse
                            }
                            
                            x += rightReverse ? CGFloat(-randomX) : CGFloat(randomX)
                            y += leftReverse ? CGFloat(-randomY) : CGFloat(randomY)
                        }
                    }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            if !alreadyConnected { // only connects the timer once
                                alreadyConnected = true
                                _ = timer.connect()
                                _ = actualTimer.connect()
                                _ = speedTimer.connect()
                                // printing values
                                print("Random Values: (\(randomX),\(randomY))")
                                print("Max Width: \(maxWidth)")
                                print("Max Height: \(maxHeight)")
                                print("Distance travelled: \(totalDistance)")
                                
                            }

                            timeElapsed = 0
                            topProgress = 0
                            rightProgress = 0
                            leftProgress = 0
                            bottomProgress = 0

                            running = true
                            
                        }, label: {
                            Image(systemName: "play.circle")
                                .imageScale(.large)
                                .padding()
                        })
                        Spacer()
                    }
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
