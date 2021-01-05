//
//  MerryChristmasView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 24/12/2020.
//

import SwiftUI

struct MerryChristmasView: View {
    
    @State var endAmount: CGFloat = 0
    @State var isFilled = false
    @State var isFlickering = false
    
    @State var canFlicker = false
    
    let initialDelay: Double = 5
    
    let timer = Timer.publish(every: 0.33, on: .main, in: .common).autoconnect()
    
    var opacity: Double {
        if isFilled {
            return canFlicker ? (isFlickering ? 0.6 : 1.0) : 1.0
        }
        return 0
    }
    
    var body: some View {
        ZStack {
            ZStack {
                MerryChristmasShape(bezier: BezierPaths().merryChristmasBezierPath)
                    .trim(from: 0, to: endAmount)
                    .stroke(Color.white, lineWidth: 2)
                
                MerryChristmasShape(bezier: BezierPaths().merryChristmasBezierPath)
                    .fill(Color.white)
                    .opacity(opacity)
                    .shadow(color: .white, radius: 12)
                    .shadow(color: .white, radius: 12)
            }
            .frame(width: 250, height: 300)
            
            .navigationBarTitle(Text("Merry Christmas!"), displayMode: .inline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.offBlack)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(Animation.linear(duration: 4).delay(initialDelay)) {
                endAmount = 1
            }
            
            withAnimation(Animation.easeInOut(duration: 0.33).delay(4 + initialDelay)) {
                isFilled.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4 + Int(initialDelay))) {
                canFlicker = true
            }
        }
        .onReceive(timer) { _ in
            withAnimation(Animation.easeInOut(duration: 0.33)) {
                isFlickering.toggle()
            }
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
}

struct MerryChristmasView_Previews: PreviewProvider {
    static var previews: some View {
        MerryChristmasView()
    }
}

struct MerryChristmasShape: Shape {
    let bezier: UIBezierPath
    
    func path(in rect: CGRect) -> Path {
        let path = Path(bezier.cgPath)
        return path.scaled(toFit: rect)
    }
}
