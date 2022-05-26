//
//  SwiftUIView.swift
//  
//
//  Created by Aryan Chaubal on 4/24/22.
//

import SwiftUI

struct SecondView: View {
    @State private var timeElapsed = 0.0
    
    var oneStar = [
        "",
        "1",
        "11",
        "111",
        "1111",
        "11111",
        "111111",
        "1111111",
        "11111111",
        "111111111",
        "1111111111",
    ]
    
    var onNext: () -> Void
    
    @State private var selectedOneStar = 0
    @State private var oneStarDir = 0
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var body: some View {
        BackgroundAnimatingView {
            ScrollView {
                VStack(spacing: 30) {
                    Text("Great! Now let's learn about Regular Expressions")
                        .font(.title)
                        .bold()
                        .opacity(timeElapsed >= 0.5 ? 1 : 0)
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                    
                    
                    Text("Regular Expressions are a powerful way to represent a regular language using characters and symbols.")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 1 ? 1 : 0)
                    
                    Text("Now let's learn the meaning of a the * in a regular expression:")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 3 ? 1 : 0)
                    
                    Text("A * following a character means that that character may appear 0 or more times. For example: ")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 4 ? 1 : 0)
                    
                    HStack {
                        Text("1*")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color("TextColor"))
                            .opacity(timeElapsed >= 5 ? 1 : 0)
                        Text("can represent")
                            .font(.title)
                            .italic()
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundColor(Color("TextColor"))
                            .opacity(timeElapsed >= 5.5 ? 1 : 0)
                        
                        ZStack {
                            HStack {
                                Spacer()
                                Text("")
                            }
                            HStack {
                                Text(oneStar[selectedOneStar])
                                    .font(.title)
                                    .bold()
                                    .underline()
                                    .foregroundColor(Color("TextColor"))
                                    .opacity(timeElapsed >= 5.5 ? 1 : 0)
                                Spacer()
                            }
                            
                            
                            
                            
                            
                        }
                        .font(.title)
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 6 ? 1 : 0)
                        
                        
                    }
                    Text("On the next page, you will see a turing machine that has been programmed to recognize the regular expression: 01*0, i.e. any string which starts and ends with a 0 and has 0 or more 1s in between. We will use a variable called state that will further help us program the machine. ")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 8 ? 1 : 0)
                    
                    Button(action: {
                        onNext()
                    }, label: {
                        Text("Let's go!")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("MainColor"))
                            .cornerRadius(10)
                    })
                        .opacity(timeElapsed >= 10 ? 1 : 0)
                    
                }
            }
            .padding()
            .padding(.vertical, 35)
        }
        .onReceive(timer) { _ in
            withAnimation(.linear(duration: 0.5)) {
                timeElapsed += 0.5
            }
            withAnimation {
                if oneStarDir == 0 {
                    selectedOneStar = selectedOneStar + 1
                    if selectedOneStar == oneStar.count {
                        selectedOneStar = selectedOneStar - 2
                        oneStarDir = 1
                    }
                } else {
                    selectedOneStar = selectedOneStar - 1
                    if selectedOneStar == -1 {
                        selectedOneStar = 1
                        oneStarDir = 0
                    }
                }
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(onNext: {
            
        })
    }
}
