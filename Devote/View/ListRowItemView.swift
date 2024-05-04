//
//  ListRowItemView.swift
//  Devote
//
//  Created by Nikolay  Yuchormanski on 4.05.24.
//

import SwiftUI

struct ListRowItemView: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    
    
    //MARK: - BODY
    var body: some View {
        Toggle(isOn: $item.completion, label: {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundStyle(item.completion ? Color.pink: Color.primary)
                .padding(.vertical,12)
                .animation(.default, value: item.completion)
        })//: Toggle
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            try? self.viewContext.save()
        })
    }
}

//MARK: - PREVIEW
//#Preview {
//    ListRowItemView()
//}
