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

    //experimental
    @State var finished = true
    // main view area
    var body: some View {
        GeometryReader { geometry in
            // getting screen size
            let maxWidth = geometry.size.width/2 - 50
            let maxHeight = geometry.size.height/2 - 50
            let totalDistance = maxWidth*4 + maxHeight * 4 // permiter
            let iteration = totalDistance / 5 * 0.005
            
            // UI code
            ZStack {

                Rectangle()
                    .overlay(ColoredRectangle()) // gives colors
                    .frame(width: 100, height: 100)
                    .scaleEffect(0.5)
                    .foregroundColor(.white)
                    .offset(x: x, y: y)
                    .animation(.easeInOut(duration:1))
                    .onReceive(timer) { _ in
                        timeElapsed += 1
                    }
                    .onReceive(speedTimer) { _ in
                        if x < maxWidth && topProgress < maxWidth*2 {
                            topProgress += iteration
                            x += iteration
                        } else {
                            if y < maxHeight && rightProgress < maxHeight*2 {
                                rightProgress += iteration
                                y += iteration
                            } else {
                                if x > -maxWidth && bottomProgress < maxWidth*2 {
                                    bottomProgress += iteration
                                    x += -iteration
                                } else {
                                    if y > -maxHeight && leftProgress < maxHeight * 2 {
                                        leftProgress += iteration
                                        y += -iteration
                                    }
                                }
                            }
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
                                // moving the rectangle to the top left corner
                                x = -maxWidth
                                y = -maxHeight
                                
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
