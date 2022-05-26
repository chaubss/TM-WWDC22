//
//  SwiftUIView.swift
//  
//
//  Created by Aryan Chaubal on 4/17/22.
//

import SwiftUI

struct IntroView: View {
    @State private var selected = 0
    @State private var data = ["0", "0", "0", "0", "1", "1", "1", "1"]
    @State private var currentState = "A"
    @State private var isTimerRunning = false
    @State private var timeElapsed = 0.0
    @State private var highlightedButtonState = 0
    
    
    var onNext: () -> Void
    
    var instructions = [
        "Click the step button to perform only one step on the turing machine.",
        "Click the play button to keep running multiple steps on the turing machine.",
        "Click the pause button to pause the turing machine in its current state.",
        "Click the reset button to reset the turing machine back to its original state.",
        "Click the next page button below to learn something about regular expressions."
    ]
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var rules = [
        "A0": "xRB",
        "Ay": "yRD",
        "A$": "ACCEPT",
        "B0": "0RB",
        "By": "yRB",
        "B1": "yLC",
        "C0": "0LC",
        "Cy": "yLC",
        "Cx": "xRA",
        "Dy": "yRD",
        "D$": "ACCEPT"
    ]
    
    func oneStep() {
        
        print("Running iteration...")
        let key = currentState + String(selected < data.count ? data[selected] : "$")
        let rule = rules[key] ?? "REJECT"
        
        if rule == "ACCEPT" {
            print("Accepted!")
            AudioPlayer.shared.playSound(soundFileName: "1")
            currentState = rule
            isTimerRunning = false
        } else if rule == "REJECT" {
            print("Rejected!")
            AudioPlayer.shared.playSound(soundFileName: "1")
            currentState = rule
            isTimerRunning = false
        } else {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.25)) {
                let direction = "\(rule[1])"
                data[selected] = "\(rule[0])"
                if direction == "R" {
                    selected += 1
//                    AudioPlayer.playSounds(soundfile: "\(selected + 1)")
                    AudioPlayer.shared.playSound(soundFileName: "\(selected)")
                } else {
                    selected -= 1
//                    AudioPlayer.playSounds(soundfile: "\(selected + 1).mp3")
                    AudioPlayer.shared.playSound(soundFileName: "\(selected)")
                    
                }
                currentState = rule[2]
            }
        }
        
    }

    
    var body: some View {
        BackgroundAnimatingView {
            VStack(spacing: 20) {
                Spacer()
                Text("Turing Machine")
                    .font(.title)
                    .bold()
                    .opacity(timeElapsed >= 0.5 ? 1 : 0)
                    .font(.title3)
                    .foregroundColor(Color("TextColor"))
                
                Text("A turing machine is a computational machine that can be thought of as a strip of tape with an infinite number of elements on one side. We can load any data on this tape and program the machine to perform the computation that we need on this data.")
                    .opacity(timeElapsed >= 1.0 ? 1 : 0)
                    .font(.title3)
                    .foregroundColor(Color("TextColor"))
                
                Text("We can use a tape pointer to see which element on the tape we are currently pointing at.")
                    .opacity(timeElapsed >= 3.5 ? 1 : 0)
                    .font(.title3)
                    .foregroundColor(Color("TextColor"))
                Spacer()
                Text("Let's try it out!")
                    .bold()
                    .opacity(timeElapsed >= 6 ? 1 : 0)
                    .font(.title2)
                    .foregroundColor(Color("TextColor"))
                
                ZStack {
                    ForEach((0..<100), id: \.self) {
                        TMTapeElement(isSelected: $0 == selected, data: $0 < data.count ? data[$0] : "$")
                            .offset(x: CGFloat(($0 - selected) * 100))
                    }
                }
                .opacity(timeElapsed >= 6.5 ? 1 : 0)
                HStack {
                    Spacer()
                    Button {

                        oneStep()
                        highlightedButtonState = 1
                    } label: {
                        Image(systemName: "arrow.turn.up.right")
                            .font(Font.title.weight(.bold))
                            .tint(Color("TextColor"))
                    }
                    .disabled(highlightedButtonState != 0)
                    Spacer()
                    Button {
                        if currentState != "ACCEPT" && currentState != "REJECT" {
                            isTimerRunning = true
                        }
                        highlightedButtonState = 2
                    } label: {
                        Image(systemName: "play")
                            .font(Font.title.weight(.bold))
                            .tint(Color("TextColor"))
                    }
                    .disabled(highlightedButtonState != 1)
                    Spacer()
                    Button {
                        isTimerRunning = false
                        highlightedButtonState = 3
                    } label: {
                        Image(systemName: "pause")
                            .font(Font.title.weight(.bold))
                            .tint(Color("TextColor"))
                    }
                    .disabled(highlightedButtonState != 2)
                    Spacer()
                    Button {
                        currentState = "A"
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.25)) {
                            selected = 0
                        }
//                        data = initData.map({ String($0) })
                        highlightedButtonState = 4
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(Font.title.weight(.bold))
                            .tint(Color("TextColor"))
                    }
                    .disabled(highlightedButtonState != 3)
                    Spacer()
                }
                .opacity(timeElapsed >= 7 ? 1 : 0)
                Text(instructions[highlightedButtonState])
                    .font(.title3)
                    .foregroundColor(Color("TextColor"))
                    .opacity(timeElapsed >= 7.5 ? 1 : 0)
                
                Group {
                
                    Button {
                        onNext()
                    } label: {
                        HStack {
                            Text("Next Page")
                            Image(systemName: "arrow.right")
                        }
                        .tint(Color("TextColor"))
                    }
                    .opacity(timeElapsed >= 7 ? 1 : 0)
                    .disabled(highlightedButtonState != 4)
                    
                    Spacer()
                }

            }
            .onReceive(timer) { _ in
                withAnimation(.linear(duration: 0.5)) {
                    timeElapsed += 0.5
                }
                
                
                if isTimerRunning {
                    oneStep()
                }
            }

            .padding()
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(onNext: {
            
        })
    }
}
