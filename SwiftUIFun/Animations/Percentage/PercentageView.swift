//
//  PercentageView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 20/12/2020.
//

import SwiftUI


enum FontScale {
    case small, large
}


struct PercentageView: View {
        
    @State private var circleProgress: CGFloat = 0.0
    
    let progress: CGFloat
    let lineWidth: CGFloat
    let startColor: Color
    let endColor: Color
    var fontScale: FontScale
    
    var gradient: AngularGradient {
        return AngularGradient(gradient: Gradient(colors: [startColor, endColor]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    var body: some View {
        ZStack {
            
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.offWhite,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .padding((lineWidth / 2) + 1)
            
            Circle()
                .trim(from: 0.0165, to: circleProgress)
                .stroke(gradient,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .bevel))
                .rotationEffect(.degrees(-90))
                .padding((lineWidth / 2) + 1)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2).delay(0.3)) {
                        self.circleProgress = (progress / 100) - 0.0165
                    }
                }
            
            Text("\(Int(progress))%")
                .font(fontScale == .small ? .caption : .headline)
                .fontWeight(fontScale == .small ? .light : .heavy)
                .padding(lineWidth)
        }
        .frame(minWidth: 50, minHeight: 50)
        
    }
}

struct PercentageView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageView(progress: 50, lineWidth: 40, startColor: .blue, endColor: .pink, fontScale: .large)
    }
}
