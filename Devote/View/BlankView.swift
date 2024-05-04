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
    //MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
        }//: VStack
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment:.center)
        .background(.black)
        .opacity(colorScheme == .light ? 0.5 : 0.6)
        .ignoresSafeArea(.all
        )
    }
}

//MARK: - PREVIEW
#Preview {
    BlankView()
}
