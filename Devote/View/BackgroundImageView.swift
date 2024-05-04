//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Nikolay  Yuchormanski on 4.05.24.
//

import SwiftUI

struct BackgroundImageView: View {
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            Image("rocket")
                .antialiased(true) // ще запази ръбовете на изображението smooth, когато се преоразмерява
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width)
        }
        .ignoresSafeArea(.all)
    }
}

//MARK: - PREVIEW
#Preview {
    BackgroundImageView()
}
