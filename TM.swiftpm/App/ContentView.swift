import SwiftUI

struct ContentView: View {
    @State private var selected = 0
    @State var initData: String
    @State private var data: [String] = []
    @State var currentState: String
    @State private var currentSpeed = 0
    @State private var currentSpeedCounter = 0
    @State private var isTimerRunning = false
    @State private var shouldShowRules = false
    @State private var shouldShowNextPageButton = false
    @State private var isFirstResponder = false
    
    var goNext: () -> Void
    
    var description: String
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var rules: [String: String]
    
    func getCurrentRule() -> String {
        if currentState == "ACCEPT" || currentState == "REJECT" {
            return "N/A"
        }
        let key = currentState + String(selected < data.count ? data[selected] : "$")
        let rule = rules[key] ?? "REJECT"
        if (rule == "ACCEPT" || rule == "REJECT") {
            return "GOTO \(rule)"
        } else {
            return "Replace \(key[1]) with \(rule[0]), Move \(rule[1] == "R" ? "Right" : "Left")"
        }
    }
    
    func getDirection() -> String {
        return "Right"
    }
    
    func oneStep() {
        
        if currentState == "ACCEPT" || currentState == "REJECT" { isTimerRunning = false; return }
        
        print("Running iteration...")
        let key = currentState + String(selected < data.count ? data[selected] : "$")
        let rule = rules[key] ?? "REJECT"
        
        if rule == "ACCEPT" {
            print("Accepted!")
            shouldShowNextPageButton = true
            AudioPlayer.shared.playSound(soundFileName: "1")
            currentState = rule
            isTimerRunning = false
        } else if rule == "REJECT" {
            shouldShowNextPageButton = true
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
        GeometryReader {_ in
            ZStack {
                BackgroundView {
                    VStack(spacing: 30) {
                        //                Spacer()
                        // Input
                        HStack(spacing: 0) {
                            Text("Input: ")
                                .font(.title.weight(.semibold))
                            //                    Text("100000")
                            //                        .font(.largeTitle.weight(.bold))
                            LegacyTextField(text: $initData, isFirstResponder: $isFirstResponder) {
                                $0.textColor = UIColor(named: "TextColor")
                                $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
                            }
                                .fixedSize()
                                .onChange(of: initData) { _data in
                                    isTimerRunning = false
                                    currentState = "A"
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.25)) {
                                        selected = 0
                                    }
                                    data = initData.map({ String($0) })
                                }
                            Button {
                                isFirstResponder.toggle()
                            } label: {
                                Image(systemName: isFirstResponder ? "checkmark" : "square.and.pencil")
                                    .font(.title2.weight(.bold))
                            }
                            .padding(.horizontal, 5)
                            
                        }
                        .foregroundColor(Color("TextColor"))
                        // Tape
                        ZStack {
                            ForEach((0..<100), id: \.self) {
                                TMTapeElement(isSelected: $0 == selected, data: $0 < data.count ? data[$0] : "$")
                                    .offset(x: CGFloat(($0 - selected) * 100))
                            }
                        }
                        // State
                        VStack {
                            HStack(spacing: 0) {
                                Text("State: ")
                                    .font(.title2.weight(.semibold))
                                Text(currentState)
                                    .font(.title2.weight(.bold))
                            }
                            HStack(spacing: 0) {
                                Text("Rule: ")
                                    .font(.title3.weight(.semibold))
                                Text("\(getCurrentRule())")
                                    .font(.title3.weight(.bold))
                            }
                        }
                        .animation(.none)
                        
                        .padding(.top, 20)
                        .foregroundColor(Color("TextColor"))
        //                Spacer()
                        // Controls
                        VStack(spacing: 40) {
                            HStack {
                                Spacer()
                                Button {
                                    oneStep()
                                } label: {
                                    Image(systemName: "arrow.turn.up.right")
                                        .font(Font.title.weight(.bold))
                                        .tint(Color("TextColor"))
                                }
                                .disabled(isTimerRunning)
                                Spacer()
                                Button {
                                    if currentState != "ACCEPT" && currentState != "REJECT" {
                                        isTimerRunning = true
                                    }
                                } label: {
                                    Image(systemName: "play")
                                        .font(Font.title.weight(.bold))
                                        .tint(Color("TextColor"))
                                }
                                .disabled(isTimerRunning)
                                Spacer()
                                Button {
                                    isTimerRunning = false
                                } label: {
                                    Image(systemName: "pause")
                                        .font(Font.title.weight(.bold))
                                        .tint(Color("TextColor"))
                                }
                                .disabled(!isTimerRunning)
                                Spacer()
                                Button {
                                    currentState = "A"
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.25)) {
                                        selected = 0
                                    }
                                    data = initData.map({ String($0) })
                                } label: {
                                    Image(systemName: "arrow.clockwise")
                                        .font(Font.title.weight(.bold))
                                        .tint(Color("TextColor"))
                                }
                                .disabled(isTimerRunning)
                                Spacer()
                            }
                            HStack(spacing: 40) {
                                Button {
                                    // reduce speed
                                    currentSpeed -= 1
                                } label: {
                                    Image(systemName: "chevron.left.2")
                                        .font(Font.title2.weight(.bold))
                                        .tint(Color("TextColor"))
                                }
                                .disabled(currentSpeed == 0)
                                Text("\(Int(pow(2.0, Double(currentSpeed))))x")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(Color("TextColor"))
                                Button {
                                    currentSpeed += 1
                                } label: {
                                    Image(systemName: "chevron.right.2")
                                        .font(Font.title2.weight(.bold))
                                        .tint(Color("TextColor"))
                                }
                                .disabled(currentSpeed == 3)
                                
                            }
                        }
                        .padding(.top, 50)
                        
                        // Description
                        ScrollView {
                            Text(description)
                                .padding(.horizontal)
                                .font(.title3.weight(.semibold))
                                .foregroundColor(Color("TextColorSecondary"))
                        }
                        // Rules Button
                        HStack {
                            Button {
                                withAnimation {
                                    shouldShowRules = true
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "list.bullet.rectangle.portrait")
                                    Text("Show Rules")
                                }
                                .foregroundColor(Color("TextColor"))
                            }
                            Spacer()
                            Button {
                                goNext()
                            } label: {
                                HStack {
                                    Text("Next Page")
                                    Image(systemName: "arrow.right")
                                }
                                .tint(Color("TextColor"))
                            }
                            .disabled(!shouldShowNextPageButton)
                        }
                        
                        

                        
                        
                        
                    }
                    .padding()
                    .onReceive(timer) { _ in
                        if isTimerRunning {
                            let every = Int(8 / pow(2.0, Double(currentSpeed)))
                            
                            if currentSpeedCounter % every == 0 {
                                oneStep()
                            }
                            currentSpeedCounter += 1
                        }
                    }
                    .onAppear {
                        data = initData.map({ String($0) })
                    }
                }
                GeometryReader { geometry in
                    RulesTableView(toggle: $shouldShowRules, rules: rules)
                        .offset(x: 0, y: shouldShowRules ? 0 : geometry.size.height + 80)
                }
               
            }
        }
        
        
        
        
        
    }
    
    
    
}
