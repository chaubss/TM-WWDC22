//
//  SwiftUIView.swift
//  
//
//  Created by Aryan Chaubal on 4/9/22.
//

import SwiftUI

struct ACText: View {
    var value: String
    var body: some View {
        Text(value)
            .font(.title3)
            .foregroundColor(Color("TextColor"))
    }
}

struct ACText_Previews: PreviewProvider {
    static var previews: some View {
        ACText(value: "Hello world!")
    }
}
