//
//  SnipItemView.swift
//  Snip
//
//  Created by Anthony Fernandez on 8/5/20.
//  Copyright © 2020 pictarine. All rights reserved.
//

import SwiftUI
import Combine


enum ModelFilter {
  case all
  case favorites
  case tag(tagTitle: String)
  
  enum Case { case all, favorites, tag }
  
  var `case`: Case {
    switch self {
      case .all: return .all
      case .favorites: return .favorites
      case .tag: return .tag
    }
  }
}



struct SnipItemView<Content: View>: View {
  
  @ObservedObject var viewModel: SnipItemViewModel
  
  @EnvironmentObject var appState: AppState
  @EnvironmentObject var settings: Settings
  
  @Environment(\.themePrimaryColor) var themePrimaryColor
  
  @State private var isExpanded: Bool = false
  @State private var isEditingName = false
  
  let content: () -> Content?
  
  @ViewBuilder
  var body: some View {
    
    if viewModel.snipItem.kind == .folder {
      
      Button(action: {
        isExpanded.toggle()
      }) {
        
        HStack {
          
          VStack {
            Spacer()
            Image( isExpanded ? "ic_up" : "ic_down")
              .resizable()
              .renderingMode(.original)
              .colorMultiply(Color.GREY_500)
              .scaledToFit()
              .frame(width: 10, height: 10, alignment: .center)
            Spacer()
          }
          .padding(.leading, 8)
          
          Image( isExpanded ? "ic_folder_opened" : "ic_folder_closed")
            .resizable()
            .renderingMode(.original)
            .colorMultiply(Color.GREY_500)
            .scaledToFit()
            .frame(width: 15, height: 15, alignment: .center)
            .padding(.leading, 8)
          
          ZStack {
            Text(viewModel.snipItem.name)
              .foregroundColor(appState.selectedSnippetId == viewModel.snipItem.id && appState.selectedSnippetFilter.case == viewModel.activeFilter.case ? .white : .text)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
              .background(Color.transparent)
              .opacity(isEditingName ? 0 : 1)
            
            TextField("Folder name", text: Binding<String>(
                        get: {
                          viewModel.snipItem.name
                        }, set: {
                          viewModel.snipItem.name = $0
                          viewModel.onTrigger(.rename(id: viewModel.snipItem.id, name: $0))
                        }),
                      onEditingChanged: { _ in
                        
                      },
                      onCommit: {
                        isEditingName.toggle()
                      }
            )
            .disabled(isEditingName == false)
            .foregroundColor(appState.selectedSnippetId == viewModel.snipItem.id && appState.selectedSnippetFilter.case == viewModel.activeFilter.case ? .white : .text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            .background(isEditingName ? themePrimaryColor : Color.transparent)
            .opacity(isEditingName ? 1 : 0)
          }
          
          .background(Color.transparent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.transparent)
        
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(0)
      .background(Color.transparent)
      .buttonStyle(PlainButtonStyle())
      .contextMenu {
        Button(action: {
          viewModel.onTrigger(.addFolder(id: viewModel.snipItem.id))
          isExpanded = true
        }) {
          Text("Add folder")
            .foregroundColor(.text)
        }
        
        Button(action: {
          viewModel.onTrigger(.addSnippet(id: viewModel.snipItem.id))
          isExpanded = true
        }) {
          Text("Add snippet")
            .foregroundColor(.text)
        }
        
        Button(action: {
          viewModel.onTrigger(.folderFromSelection(id: viewModel.snipItem.id))
        }) {
          Text("Folder from this")
            .foregroundColor(.text)
        }
        
        Button(action: { isEditingName.toggle() }) {
          Text("Rename")
            .foregroundColor(.text)
        }
        
        Button(action: {
          viewModel.onTrigger(.delete(id: viewModel.snipItem.id))
        }) {
          Text("Delete")
            .foregroundColor(.text)
        }
      }
      
    }
    else {
      Button(action: viewModel.openSnippet) {
        HStack {
          Image(viewModel.snipItem.mode.imageName)
            .resizable()
            .renderingMode(appState.selectedSnippetId == viewModel.snipItem.id && appState.selectedSnippetFilter.case == viewModel.activeFilter.case ? .template : .original)
            .colorMultiply(.white)
            .scaledToFit()
            .frame(width: 15, height: 15, alignment: .center)
            .padding(.leading, 8)
          
          ZStack {
            Text(self.viewModel.snipItem.name)
              .foregroundColor(appState.selectedSnippetId == viewModel.snipItem.id && appState.selectedSnippetFilter.case == viewModel.activeFilter.case ? .white : .text)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 4)
              .background(Color.transparent)
              .opacity(isEditingName ? 0 : 1)
            
            TextField("Snip name", text: Binding<String>(
                        get: {
                          viewModel.snipItem.name
                        }, set: {
                          viewModel.snipItem.name = $0
                          viewModel.onTrigger(.rename(id: viewModel.snipItem.id, name: $0))
                        }),
                      onEditingChanged: { _ in
                        
                      },
                      onCommit: {
                        isEditingName.toggle()
                      }
            )
            .disabled(isEditingName == false)
            .foregroundColor(appState.selectedSnippetId == viewModel.snipItem.id && appState.selectedSnippetFilter.case == viewModel.activeFilter.case ? .white : .text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 4)
            .background(isEditingName ? themePrimaryColor : Color.transparent)
            .opacity(isEditingName ? 1 : 0)
          }
          
          .background(Color.transparent)
          
          Spacer()
          Circle()
            .fill(viewModel.snipItem.syncState == .local ? Color.clear : Color.green)
            .frame(width: 8, height: 8)
            .padding(.trailing, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        .background(Color.transparent)
      }
      .contextMenu {
        
        Button(action: {
          viewModel.onTrigger(.folderFromSelection(id: viewModel.snipItem.id))
        }) {
          Text("Folder from this")
            .foregroundColor(.text)
        }
        
        Button(action: {
          isEditingName.toggle()
        }) {
          Text("Rename")
            .foregroundColor(.text)
        }
        
        Button(action: {
          viewModel.onTrigger(.delete(id: viewModel.snipItem.id))
          appState.selectedSnippetId = nil
        }) {
          Text("Delete")
            .foregroundColor(.text)
        }
      }
      .buttonStyle(PlainButtonStyle())
      .background(appState.selectedSnippetId == viewModel.snipItem.id && appState.selectedSnippetFilter.case == viewModel.activeFilter.case ? .accentDark : Color.transparent)
      .cornerRadius(4)
    }
    
    if isExpanded {
      content()
    }
  }
  
}


final class SnipItemViewModel: ObservableObject {
  
  @Published var snipItem: SnipItem
  
  var activeFilter: ModelFilter
  var onTrigger: (SnipItemsListAction) -> Void
  var onSnippetSelection: (SnipItem, ModelFilter) -> Void
  
  init(snip: SnipItem,
       activeFilter: ModelFilter,
       onTrigger: @escaping (SnipItemsListAction) -> Void,
       onSnippetSelection: @escaping (SnipItem, ModelFilter) -> Void) {
    self.snipItem = snip
    self.activeFilter = activeFilter
    self.onTrigger = onTrigger
    self.onSnippetSelection = onSnippetSelection
  }
  
  func openSnippet() {
    onSnippetSelection(snipItem, activeFilter)
  }
}
