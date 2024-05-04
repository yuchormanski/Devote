//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Nikolay  Yuchormanski on 4.05.24.
//

import SwiftUI

#if canImport(UIKit)
extension  View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
