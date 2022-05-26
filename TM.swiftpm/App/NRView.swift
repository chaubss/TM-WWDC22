//
//  NRView.swift
//  
//
//  Created by Aryan Chaubal on 4/25/22.
//

import SwiftUI

struct NRView: View {
    
    var onNext: () -> Void
    
    @State private var timeElapsed = 0.0
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        BackgroundAnimatingView {
            ScrollView {
                VStack(spacing: 30) {
                    Text("Working with Languages that are not Regular")
                        .font(.title)
                        .bold()
                        .opacity(timeElapsed >= 0.5 ? 1 : 0)
                        .foregroundColor(Color("TextColor"))
                    
                    
                    Text("Can you create a regular expression for 1s followed by 0s such that the number of 0s and 1s are the same?")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 1 ? 1 : 0)
                    
                    Text("Turns out you can't!")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 3 ? 1 : 0)
                    
                    Text("A language that cannot be represented by a regular expressions are called non-regular languages.")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 4 ? 1 : 0)
                    
                    Text("Turing machines are quite versatile can and hence can be used to identify this language. In fact, turing machines can do so much that the capability of a programming language is measured by comparing them to turing machines.")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 6 ? 1 : 0)
                    
                    Text("A programming language is said to be turing complete if it can do everything that a turing machine can.")
                        .font(.title3)
                        .foregroundColor(Color("TextColor"))
                        .opacity(timeElapsed >= 6 ? 1 : 0)
                    
                    
                    Button(action: {
                        onNext()
                    }, label: {
                        Text("Let's see how!")
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
        }
    }
}

struct NRView_Previews: PreviewProvider {
    static var previews: some View {
        NRView {
            
        }
    }
}
