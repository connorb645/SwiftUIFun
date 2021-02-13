//
//  LightlyFlickeringBackgroundView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 13/01/2021.
//

import SwiftUI

struct LightlyFlickeringBackgroundView: View {
    
    let rows = 10
    let columns = 5
    
    @State var isAnimated = false
    
    let animationDuration = 1.0
    
    var body: some View {
        
        VStack {
            
            ForEach(0..<rows) { row in
                
                HStack {
                    
                    ForEach(0..<columns) { column in
                        Spacer()
                        Image("twitter-logo")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.blue.opacity(0.2))
                            .scaledToFit()
                            .opacity(isAnimated ? 1 : 0)
                            .animation(Animation
                                        .easeInOut(duration: Double.random(in: 1...2))
                                        .repeatForever(autoreverses: true)
                                        .delay(Double.random(in: 0...1.5)))
                            
                        Spacer()
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.offWhite)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            isAnimated.toggle()
        }
                
    }
}

struct LightlyFlickeringBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        LightlyFlickeringBackgroundView()
    }
}
