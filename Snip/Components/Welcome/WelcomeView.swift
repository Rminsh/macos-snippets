//
//  WelcomeView.swift
//  Snip
//
//  Created by Anthony Fernandez on 9/8/20.
//  Copyright © 2020 pictarine. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
  
  @EnvironmentObject var settings: Settings
  
  @Environment(\.themeSecondaryColor) var themeSecondaryColor
  @Environment(\.themePrimaryColor) var themePrimaryColor
  @Environment(\.themeTextColor) var themeTextColor
  @Environment(\.themeShadowColor) var themeShadowColor
  
  @ObservedObject var viewModel: WelcomeViewModel
  
  @State var currentPage = 0
  
  var body: some View {
    ZStack {
      
      backgroundView
        .frame(width: viewModel.size.width, height: viewModel.size.height)
        .transition(AnyTransition.opacity)
      
      firstView
        .frame(width: viewModel.size.width / 2.5,
               height: viewModel.size.height / 1.5,
               alignment: .center)
        .background(themeSecondaryColor)
        .cornerRadius(4.0)
        .offset(x: 0,
                y: viewModel.isVisible ? ((viewModel.size.height / 2) - ((viewModel.size.height / 1.5) / 1.5)) : 10000)
        .transition(AnyTransition.move(edge: .bottom))
    }
  }
  
  var firstView: some View {
    VStack {
      HStack {
        Spacer()
        Text("Welcome!")
          .foregroundColor(themeTextColor)
          .font(.title)
        Spacer()
      }
      Text("Changelog Ver. \(Bundle.main.releaseVersionNumber)")
        .font(.subheadline)
        .foregroundColor(themeTextColor)
        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
      HStack {
        Text("- Update for Big Sur compatibility\n- Fix code editor issue\n- Open folder when we add a new element\n- Add toolbar item\n- Sidebar can be expanded/collapsed\n PHP now has syntax highlighting without tags\n- Improve UI and clickable areas")
          .font(Font.custom("CourierNewPSMT", size: 12))
          .foregroundColor(themeTextColor)
        Spacer()
      }
      .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
      .background(themePrimaryColor)
      Text("We Need Your Help!")
        .font(.subheadline)
        .foregroundColor(themeTextColor)
        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
      CodeView(code: .constant("Snip needs your help to grow!\n\nWant to translate snip into your native language?\nWant to have first-day in our next features?\n\nJOIN US now!"),
               mode: .constant(CodeMode.text.mode()),
               isReadOnly: true)
        .frame(maxWidth: .infinity)
      Spacer()
      HStack {
        Spacer()
        Button(action: self.viewModel.close) {
          Text("Close")
            .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
            .foregroundColor(themeTextColor)
            .background(Color.transparent)
        }
        .buttonStyle(PlainButtonStyle())
        Button(action: self.viewModel.openSnipWebsite) {
          Text("JOIN US")
            .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
            .foregroundColor(.white)
            .background(Color.accentDark)
            .cornerRadius(4)
        }
        .buttonStyle(PlainButtonStyle())
      }
    }
    .padding()
  }
  
  var backgroundView: some View {
    viewModel.isVisible ? themeShadowColor : Color.clear
  }
}

final class WelcomeViewModel: ObservableObject {
  
  @Binding var isVisible: Bool
  var size: CGSize
  
  init(isVisible: Binding<Bool>, readerSize: CGSize) {
    self._isVisible = isVisible
    self.size = readerSize
  }
  
  func close() {
    
    withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.3)) { () -> () in
      self.isVisible = false
    }
  }
  
  func openSnipWebsite() {
    guard let url = URL(string: "https://snip.picta-hub.io") else { return }
    NSWorkspace.shared.open(url)
    
    self.close()
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView(viewModel: WelcomeViewModel(isVisible: .constant(true),
                                            readerSize: CGSize(width: 300, height: 400)))
  }
}
