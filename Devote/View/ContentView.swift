//
//  ContentView.swift
//  Devote
//
//  Created by Nikolay  Yuchormanski on 3.05.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - PROPERTY
    
    
    @Environment(\.colorScheme) var colorScheme // detect color scheme // custom
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: - FUNCTIONS
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    //MARK: - BODY
    var body: some View {
        //        NavigationView { // will be deprecated in future OS
        NavigationStack {
            ZStack {
                //MARK: - MAIN VIEW
                VStack {
                    //MARK: - HEADER
                    HStack(spacing: 10, content: {
                        //TITLE
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        Spacer()
                        //EDIT BTN
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        //APPEARANCE BTN
                        Button(action: {
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                        
                    })
                    .padding()
                    .foregroundStyle(.white)
                    
                    Spacer(minLength: 80)
                    //MARK: - NEW TASK BUTTON
                    
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)
                    
                    
                    //MARK: - TASKS
                    VStack {
                        List {
                            ForEach(items) { item in
                                NavigationLink {
                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                } label: {
                                    ListRowItemView(item: item)
                                }//: Navigation
                            }//: LOOP
                            .onDelete(perform: deleteItems)
                        }//: List
                        .listStyle(InsetGroupedListStyle())
                        .scrollContentBackground(.hidden) // hide List, TableView background
                        .background(Color.clear) // probably is not needed this
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 6, y: 8)
                        .padding(.vertical, 0)
                        .frame(maxWidth: 640)
                        
                    }//: VStack
                }//: VStack
                
                //MARK: - NEW TASK ITEM
                if showNewTaskItem {
                    BlankView()
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.3)) {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
                
            }//: ZStack
            //next is not working on this version of xcode. Use code on line 111
            //                        .onAppear(){
            //                            UITableView.appearance().backgroundColor = UIColor.clear
            //                        }
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.hidden)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
        }//: Navigation
        // will be deprecated in the future OS
        // подсигурява , че кода ще се вижда като една колона и няма да се рапне , особено при таблетите
        //        .navigationViewStyle(StackNavigationViewStyle())
    }
}


//MARK: - PREVIEW
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
