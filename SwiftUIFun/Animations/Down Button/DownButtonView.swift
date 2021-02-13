//
//  DownButtonView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 30/01/2021.
//

import SwiftUI

struct DownButtonView: View {
    
    @State var isArrowPushedDown: Bool = false
    @State var isSplashVisible: Bool = false
    @State var isFillVisible: Bool = false
    @State var percentage: CGFloat = 0.0
    
    let springAnimation = Animation.spring(response: 0.8, dampingFraction: 0.4, blendDuration: 0)
    
    var body: some View {
        DBContainer {
            GeometryReader { geo in
                ZStack {
                    Button(action: {
                        
                        // Arrow Animation
                        
                        withAnimation(Animation.easeOut(duration: 0.5)) {
                            isArrowPushedDown.toggle()
                        }
                        
                        // Splash Animation
                        
                        delay(0.15) {
                            withAnimation(springAnimation) {
                                isSplashVisible.toggle()
                            }
                            
                            delay(0.5) {
                                withAnimation(springAnimation) {
                                    isSplashVisible.toggle()
                                }
                            }
                        }
                        
                        // Progress Animation
                        delay(0.8) {
                            runCounter(counter: $percentage, start: 0.0, end: 1.0, increment: 0.01, speed: 0.02)
                        }
                        
                    }, label: {
                        ZStack {
                            
                            circle
                                                        
                            downArrow(geo: geo)
                            
                            curvyTriangle(geo: geo)
                            
                            fill(geo: geo)
                            
                            percentageLabel
                        }
                        .clipShape(Circle())
                    })
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
    
    var circle: some View {
        Circle()
            .stroke(Color.offWhite, lineWidth: 4)
    }
    
    func downArrow(geo: GeometryProxy) -> some View {
        Image(systemName: "arrow.down")
            .resizable()
            .foregroundColor(.offWhite)
            .frame(width: geo.size.width * 0.35, height: geo.size.height * 0.35)
            .offset(y: isArrowPushedDown ? geo.size.height : 0)
    }
    
    func curvyTriangle(geo: GeometryProxy) -> some View {
        CurvyTriangle()
            .fill(Color.offWhite)
            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.25)
            .offset(y: isSplashVisible ? geo.size.height * 0.4 : geo.size.height * 0.7)
    }
    
    func fill(geo: GeometryProxy) -> some View {
        Rectangle()
            .fill(Color.offWhite)
            .offset(y: geo.size.height - (geo.size.height * percentage))
    }
    
    var percentageLabel: some View {
        Text("\(String(format: "%.0f", percentage * 100))%")
            .foregroundColor(.offBlack)
            .font(.title3)
            .fontWeight(.bold)
            .opacity(Double(percentage))
    }
    
}

struct DownButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DownButtonView()
    }
}

struct DBContainer<Content: View>: View {
    var content: () -> Content
    
    var body: some View {
        ZStack {
            Color.offBlack.edgesIgnoringSafeArea(.all)
            
            ZStack {
                content()
            }
            .frame(width: 100, height: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
