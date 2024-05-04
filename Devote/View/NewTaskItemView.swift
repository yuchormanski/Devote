//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Nikolay  Yuchormanski on 4.05.24.
//

import SwiftUI

struct NewTaskItemView: View {
    //MARK: - PROPERTIES
    @Environment(\.colorScheme) var colorScheme // custom
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true // false is only for initialize
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var task: String = ""
    
    @Binding var isShowing: Bool
    
    //Computed property защита от запис с празно поле
    // проверява дали инпут полето е празно
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    //MARK: - FUNCTIONS
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = "" // clear the text field
            hideKeyboard() // hidding the keyboard. Func is imported from custom extension
            isShowing = false
        }
    }
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 16, content: {
                TextField("New Task", text: $task)
                    .foregroundStyle(colorScheme == .light ? .pink : .white)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background( isDarkMode ?
                                 Color(UIColor.tertiarySystemBackground) :
                                    Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button(action: {
                    addItem()
                }, label: {
                    Spacer()
                    Text("Save".uppercased())
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisabled)
                .padding()
                .foregroundStyle(.white)
                //                    .background(isButtonDisabled ? .gray : .pink)
                .background(.blue)
                .opacity(isButtonDisabled ? 0 : 1)
                .offset(x: isButtonDisabled ?  375 : 0, y: isButtonDisabled ? 50 : 0 )
                .scaleEffect(isButtonDisabled ? 0 : 1)
                .cornerRadius(10)
            })//: VStack
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background( isDarkMode ? Color.indigo : Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.35), radius: 14, x: 0, y: 0)
            .frame(maxWidth: 640)
            
            .animation(.spring(duration: 0.35), value: isButtonDisabled)
        }//: VStack
        .padding()
        
    }
}

//MARK: - PREVIEW
#Preview{
    NewTaskItemView(isShowing: .constant(true))
        .background(Color.gray.edgesIgnoringSafeArea(.all))
        
}
