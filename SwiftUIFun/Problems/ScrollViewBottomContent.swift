//
//  ScrollViewBottomContent.swift
//  SwiftUIFun
//
//  Created by Connor Black on 14/07/2021.
//

import SwiftUI

struct ChildContainerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ScrollViewBottomContent<Content: View>: View {
    
    var content: Content
    @State var loginContainerSize: CGSize = .zero
        
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: max(300, proxy.size.height - loginContainerSize.height))
                    
                    ZStack {
                        Color.white
                        content
                            .padding(32)
                    }
                    
                    .frame(maxWidth: .infinity)
                    .cornerRadius(30)
                    
                    .overlay(GeometryReader { proxy in
                        Rectangle()
                            .foregroundColor(.clear)
                            .preference(key: ChildContainerHeightPreferenceKey.self, value: proxy.size)
                    })
                    .onPreferenceChange(ChildContainerHeightPreferenceKey.self) { newValue in
                        self.loginContainerSize = newValue
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ScrollViewBottomContent_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewBottomContent {
            ZStack {
                Color.blue
            }
            .frame(height: 500)
        }
    }
}
