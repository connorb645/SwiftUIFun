//
//  ThreeDotsLoaderView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 10/12/2020.
//

import SwiftUI

struct ThreeDotsLoaderView: View {
    @State var currentPhase: Int = 0
        
    func top(_ geo: GeometryProxy) -> CGPoint {
        return .init(x: 0, y: -geo.size.width / 3)
    }
    
    func left(_ geo: GeometryProxy) -> CGPoint {
        return .init(x: -geo.size.width / 3, y: geo.size.width / 3)
    }
   
    func right(_ geo: GeometryProxy) -> CGPoint {
        return .init(x: geo.size.width / 3, y: geo.size.width / 3)
    }
    
    var body: some View {
        ZStack {
            ZStack {
                GeometryReader { geo in
                    ZStack {
                        
                        Circle()
                            .foregroundColor(Color.lightGreen)
                            .frame(width: geo.size.width / 3)
                            .offset(x: currentPhase == 0 ? top(geo).x : currentPhase == 1 ? right(geo).x : left(geo).x,
                                    y: currentPhase == 0 ? top(geo).y : currentPhase == 1 ? right(geo).y : left(geo).y)
                        
                        Circle()
                            .foregroundColor(Color.mediumGreen)
                            .frame(width: geo.size.width / 3)
                            .offset(x: currentPhase == 0 ? right(geo).x : currentPhase == 1 ? left(geo).x : top(geo).x,
                                    y: currentPhase == 0 ? right(geo).y : currentPhase == 1 ? left(geo).y : top(geo).y)

                        Circle()
                            .foregroundColor(Color.darkGreen)
                            .frame(width: geo.size.width / 3)
                            .offset(x: currentPhase == 0 ? left(geo).x : currentPhase == 1 ? top(geo).x : right(geo).x,
                                    y: currentPhase == 0 ? left(geo).y : currentPhase == 1 ? top(geo).y : right(geo).y)
                        
                    }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                }
                .navigationBarTitle(Text("Three Dots Loader"), displayMode: .inline)
            }
            .frame(width: 150, height: 150)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
                    withAnimation(Animation
                                    .easeInOut(duration: 0.7)
                                    .delay(0.0)) {
                        self.currentPhase = (self.currentPhase + 1) % 3
                    }
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.offBlack)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct ThreeDotsLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDotsLoaderView()
    }
}
