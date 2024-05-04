//
//  BlankView.swift
//  Devote
//
//  Created by Nikolay  Yuchormanski on 4.05.24.
//

import SwiftUI

struct BlankView: View {
    
    //MARK: - PROPERTIES
    @Environment(\.colorScheme) var colorScheme
    var backgroungColor: Color
    var backgroundOpacity: Double
    
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
        }//: VStack
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:.center)
        .background(backgroungColor)
//        .opacity(colorScheme == .light ? 0.5 : 0.8)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .ignoresSafeArea(.all
        )
    }
}

//MARK: - PREVIEW
#Preview {
    BlankView(backgroungColor: .black, backgroundOpacity: 0.3)
        .background(BackgroundImageView())
        .background(backgroundGradient.ignoresSafeArea(.all))
    
}
