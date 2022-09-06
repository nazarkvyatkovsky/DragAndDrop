//
//  ContentView.swift
//  Drag and Drop
//
//  Created by Nazar Kvyatkovsky on 9/6/22.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    var leftTitles = ["SpaceX Falcon 1", "iPhone 1","Windows 7", "Instagram"]
    var items = ["March 2006", "January 2007","October 2009", "October 2010"].shuffled()
    var currentItem: String?
    @Published var isDragging = false
}

struct ContentView: View {
    @ObservedObject var model = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Drag the option on the right to match the choice on the left.")
                .font(.system(size: 24))
                .fontWeight(.medium)
                .frame(maxWidth: .infinity,alignment:.leading)
                .padding(20)
            HStack {
                leftStack
                /// Right Draggable Stack
                rightStack
            }.padding(.horizontal,20)
        }
    }
    
    var leftStack: some View {
        VStack{
            ForEach(model.leftTitles, id: \.self) { item in
                VStack {
                    Text(item)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .padding(.horizontal,16)
                        .minimumScaleFactor(0.01)
                }
                .frame(height:50)
                .background(Color("light-gray"))
                .cornerRadius(12, corners: [.topLeft, .bottomLeft])
            }
        }
    }
    
    var rightStack: some View {
        LazyVStack() {
            ForEach(model.items, id:\.self) { item in
                VStack {
                    Text(item)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .padding(.horizontal,16)
                        .minimumScaleFactor(0.01)
                }
                .frame(height:50)
                .background(Color.white)
                .overlay(
                    CornerShape(radius: 12, corners: [.topRight, .bottomRight])
                        .stroke(Color("light-gray"), lineWidth: 4)
                )
                .cornerRadius(12, corners: [.topRight, .bottomRight])
                .contentShape([.dragPreview],CornerShape(radius: 12, corners: [.topRight, .bottomRight]))
                .overlay(model.currentItem == item && model.isDragging ? .white: .clear)
                .onDrag {
                    model.currentItem = item
                    return NSItemProvider(contentsOf: URL(string: "\(item)"))!
                }
                .onDrop(of: [.text], delegate: ItemDropDelegate(item: item, model: model))
            }
        }
    }
}

//MARK: Drop Delegate
struct ItemDropDelegate: DropDelegate {
    let item: String
    var model: ContentViewModel
    
    /// Drop finished work
    func performDrop(info: DropInfo) -> Bool {
        model.currentItem = nil
        model.isDragging = false
        return true
    }
    
    /// Moving style without "+" icon
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    /// Object is dragged off of the onDrop view.
    func dropExited(info: DropInfo) {
        model.isDragging = false
    }
    
    /// Object is dragged over the onDrop view.
    func dropEntered(info: DropInfo) {
        model.isDragging = true
        guard let dragItem = model.currentItem, dragItem != item,
              let from = model.items.firstIndex(of: dragItem),
              let to = model.items.firstIndex(of: item) else {return}
        model.items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
    }
}

//MARK: Specific corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CornerShape(radius: radius, corners: corners))
    }
}

struct CornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
