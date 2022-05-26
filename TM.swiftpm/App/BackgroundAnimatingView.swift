//
//  SwiftUIView.swift
//  
//
//  Created by Aryan Chaubal on 4/24/22.
//

import SwiftUI

struct BackgroundAnimatingView<Content: View>: View {
    let viewBuilder: () -> Content
    @State var animating = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(hex: "D6FFB7")
                    
                VStack(spacing: 10) {
                    ForEach((0..<Int((geometry.size.height - 20) / 26)), id: \.self) { _ in
                        HStack(spacing: 10) {
                            
                            ForEach((0..<Int((geometry.size.width - 20) / 26)), id: \.self) {_ in
                                RoundedRectangle(cornerRadius: 2)
                                    .foregroundColor(Color("MainColor"))
                                    .frame(width: 16, height: 16)
                                    .opacity(self.animating ? 0.15 : 0)
                                    .animation(
                                        Animation.linear(duration: Double.random(in: 1.0 ... 2.0))
                                                    .repeatForever()
                                                    .delay(Double.random(in: 0 ... 1.5))
                                    )
                            }
                        }
                    }
                    .onAppear {
                        animating = true
                    }
                    
                }
                viewBuilder()
            }
        }
        .ignoresSafeArea()
        
        
    }
}

struct BackgroundAnimatingView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundAnimatingView {
            Text("Hello, World!")
        }
    }
}
