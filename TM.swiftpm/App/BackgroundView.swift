//
//  SwiftUIView.swift
//  
//
//  Created by Aryan Chaubal on 4/9/22.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    let viewBuilder: () -> Content
    var body: some View {
        ZStack {
            Color(hex: "D6FFB7")
                .ignoresSafeArea()
            viewBuilder()
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BackgroundView {
                Text("Hello World!")
            }
            BackgroundView {
                Text("Hello World!")
            }
            .preferredColorScheme(.dark)
        }
    }
}
