import SwiftUI

@main
struct ColorGridApp: App {
    @State private var currentView = 0

    var body: some Scene {
        WindowGroup {
            ZStack {
                if currentView == 0 {
                    IntroView(onNext: {
                        withAnimation {
                            currentView = 1
                        }
                    })
                } else if currentView == 1 {
                    SecondView {
                        withAnimation {
                            currentView = 2
                        }
                    }
                } else if currentView == 2 {
                    // 01*0
                    
                    ContentView(initData: "011110", currentState: "A", goNext: {
                        currentView = 3
                    }, description: "This is a Turing Machine to recognize the regular expressions: 01*0. The outcome depends on the final value: either ACCEPT or REJECT. You can edit the input to try a REJECT condition.", rules: [
                        "A0": "xRB",
                        "B1": "yRB",
                        "B0": "xRC",
                        "C$": "ACCEPT"
                        
                    ])
                    
                } else if currentView == 3 {
                    // non-regular languages
                    NRView {
                        currentView = 4
                    }
                    
                } else if currentView == 4 {
                    // 0^n 1^n
                    
                    ContentView(initData: "00001111", currentState: "A", goNext: {
                        currentView = 5
                    }, description: "This is a Turing Machine to recognize languages of the form 0\u{207f}1\u{207f} (Any number of 0s followed by equal number of 1s). The outcome depends on the final value: either ACCEPT or REJECT. You can edit the input to try a REJECT condition.", rules: [
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
                    ])
                    
                } else {
                    // Final page
                    BackgroundAnimatingView {
                        VStack {
                            Spacer()
                            Text("Thank you!")
                                .font(.title)
                                .bold()
                                .foregroundColor(Color("TextColor"))
                            Spacer()
                        }
                    }
                }
            }
            .onChange(of: currentView) { newVal in
                withAnimation {
                    currentView = newVal
                }
            }
            
        }
    }
}
