//
//  CodeViewer.swift
//  Snip
//
//  Created by Anthony Fernandez on 7/29/20.
//  Copyright © 2020 pictarine. All rights reserved.
//

import SwiftUI

struct CodeViewer: View {
  
  @State var mode = CodeMode.text.mode()
  @State var code = try! String(contentsOf: Bundle.main.url(forResource: "data", withExtension: "json")!)
  @State var tags = ["json", "matrix", "pinguin"]
  
  var body: some View {
    VStack(alignment: .leading) {
      CodeActionsTopBar(viewModel: CodeActionsViewModel(id: UUID(),
      name: "Curry Func",
      isFavorite: true))
      
      ModeSelectionView(currentMode: $mode, tags: $tags)
      
      CodeView(code: $code, mode: $mode, onContentChange: { content in
        self.code = content
      })
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
      
      Divider()
      
      CodeDetailsBottomBar(viewModel: CodeDetailsViewModel(), code: code)
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    .background(Color.BLACK_500)
    .listStyle(PlainListStyle())
  }
  
  
}

struct CodeViewer_Previews: PreviewProvider {
  static var previews: some View {
    CodeViewer()
  }
}
