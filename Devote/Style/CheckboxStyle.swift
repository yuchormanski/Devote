//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Nikolay  Yuchormanski on 4.05.24.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill": "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    
                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                        feedback.impactOccurred()
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                        feedback.impactOccurred()
                    }
                }
            configuration.label
        }//: HStack
    }
}

//MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    Toggle("Placeholder label", isOn: .constant(true))
        .toggleStyle(CheckboxStyle())
        .padding()
}
