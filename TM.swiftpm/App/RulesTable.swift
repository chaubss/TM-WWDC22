//
//  SwiftUIView.swift
//  
//
//  Created by Aryan Chaubal on 4/9/22.
//

import SwiftUI

struct ACGridItem: View {
    var value: String
    var bold: Bool = false
    var header: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            if bold {
                Text(value)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("TextColor"))
            } else {
                if (value == "->") {
                    Image(systemName: "arrow.right")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color("TextColor"))
                } else if (value == "<-") {
                    Image(systemName: "arrow.left")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color("TextColor"))
                } else {
                    Text(value)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color("TextColor"))
                }
            }
            Spacer()
        }
        .padding(.vertical, 10)
//        .background(header ? Color("MainColor").opacity(0.3) : Color.clear)
    }
}

struct RulesTableView: View {
        
    @Binding var toggle: Bool
    
    var rules: [String: String] = [
        "A0": "xRB",
        "Ay": "yRD",
        "B0": "0RB",
        "By": "yRB",
        "B1": "yLC",
        "C0": "0LC",
        "Cy": "yLC",
        "Cx": "xRA",
        "Dy": "yRD",
        "D$": "ACCEPT"
        
    ]
    var body: some View {
        BackgroundView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)], spacing: 0) {
                    ACGridItem(value: "When I am in state:", bold: true, header: true)
                    ACGridItem(value: "And I see input:", bold: true, header: true)
                    ACGridItem(value: "Replace input with:", bold: true, header: true)
                    ACGridItem(value: "Move on tape:", bold: true, header: true)
                    ACGridItem(value: "And go to state:", bold: true, header: true)
                    
                    ForEach(Array(rules.keys), id: \.self) {
                        let key = $0
                        let rule = rules[key]!
                        ACGridItem(value: key[0])
                        ACGridItem(value: key[1])
                        if (rule == "REJECT" || rule == "ACCEPT") {
                            ACGridItem(value: "")
                            ACGridItem(value: "")
                            ACGridItem(value: rule)
                        } else {
                            ACGridItem(value: rule[0])
                            ACGridItem(value: rule[1] == "R" ? "->" : "<-")
                            ACGridItem(value: rule[2])
                        }
                        
                    }
                }
                .background(Color("MainColor").opacity(0.2))
                .cornerRadius(5)
                .padding()
                Spacer()
                Button(action: {
                    withAnimation {
                        toggle = false
                    }
                }, label: {
                    Text("Go Back")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("MainColor"))
                        .cornerRadius(10)
                })
            }
        }
        
    }
}

struct RulesTableView_Previews: PreviewProvider {
    static var previews: some View {
        RulesTableView(toggle: .constant(true))
    }
}
