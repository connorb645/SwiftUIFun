//
//  DismissableNavigationView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 25/01/2021.
//

import SwiftUI

struct DismissableNavigationView: View {
    
    @State var topPadding: CGFloat = 0
    @State var bottomPadding: CGFloat = 0
    @State var isTopOpen: Bool = false
    @State var isBottomOpen: Bool = false
    
    let height: CGFloat = 60
    
    var body: some View {
        ZStack {
            Color.offBlack
                .edgesIgnoringSafeArea(.all)
            
            navigationAndTabBarView
            
            mainContentView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var mainContentView: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.pink)
                .overlay(fakeContentOverlayView)
                .clipped()
                .padding(.top, topPadding)
                .padding(.bottom, bottomPadding)
                .edgesIgnoringSafeArea(.bottom)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let threshold = geo.size.height / 2
                            
                            if gesture.startLocation.y < threshold {
                                topPadding = isTopOpen ? gesture.translation.height + 60 : gesture.translation.height
                            } else {
                                bottomPadding = isBottomOpen ? -(gesture.translation.height - 60) : -gesture.translation.height
                            }
                        }
                        .onEnded { gesture in
                            let threshold = geo.size.height / 2
                            
                            withAnimation(Animation.spring()) {
                                if gesture.startLocation.y < threshold {
                                    topPadding = gesture.translation.height < 0 ? 0 : 60
                                    
                                    isTopOpen = gesture.translation.height < 0 ? false : true
                                } else {
                                    bottomPadding = gesture.translation.height > 0 ? 0 : 60
                                    
                                    isBottomOpen = gesture.translation.height > 0 ? false : true
                                }
                            }
                        }
                )
        }
    }
    
    var navigationAndTabBarView: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                Spacer()
                Text("Dismissable Navigation")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "gear")
            }
            .padding(.horizontal)
            .frame(height: height)
            .foregroundColor(.white)
            
            Spacer()
            
            HStack {
                Spacer()
                Image(systemName: "house")
                Spacer()
                Image(systemName: "plus.square")
                Spacer()
                Image(systemName: "message")
                Spacer()
            }
            .frame(height: height)
            .foregroundColor(.white)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var fakeContentOverlayView: some View {
        FakeContentView(rowCount: 10, rowColor: .white).frame(maxWidth: .infinity).frame(height: 500).padding()
    }
    
}

struct DismissableNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        DismissableNavigationView()
    }
}
