//
//  SwiftUIView.swift
//  
//
//  Created by Aryan Chaubal on 4/7/22.
//

import SwiftUI

struct TMTapeElement: View {
    var isSelected: Bool = false
    var data: String = "$"
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: isSelected ? 100 : 80, height: isSelected ? 100 : 80, alignment: .center)
                .foregroundColor(isSelected ? Color("MainColor") : Color("MainColor").opacity(0.5))
            Text(data)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .medium, design: .rounded))
                .scaleEffect(isSelected ? 1.5 : 1)
        }
    }
}

struct TMTapeElement_Previews: PreviewProvider {
    static var previews: some View {
        TMTapeElement()
    }
}
