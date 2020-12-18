//
//  PintView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 12/12/2020.
//

import SwiftUI

extension Path {
    var reversed: Path {
        let reversedCGPath = UIBezierPath(cgPath: cgPath)
            .reversing()
            .cgPath
        return Path(reversedCGPath)
    }
}

struct Pint: Shape {
    
    let cornerRadius: CGFloat
    
    init(cornerRadius: CGFloat = 20) {
        self.cornerRadius = cornerRadius
    }
    
    func path(in rect: CGRect) -> Path {
        
        let widthPartition: CGFloat = rect.size.width / 3
        let heightPartition: CGFloat = rect.size.height / 5
        
        let handleRadius = cornerRadius / 2
        let innerHandleRadius = handleRadius / 2
        
        let handleThickness: CGFloat = 15
        
        let topLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: widthPartition * 2, y: 0)
        let bottomLeft = CGPoint(x: 0, y: rect.size.height)
        let bottomRight = CGPoint(x: widthPartition * 2, y: rect.size.height)
        
        var beerOutlinePath = Path()
        
        beerOutlinePath.move(to: topLeft)
        
        beerOutlinePath.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y - cornerRadius))
        beerOutlinePath.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y))

        
        beerOutlinePath.addLine(to: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y))
        beerOutlinePath.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadius))
        
        beerOutlinePath.addLine(to: topRight)
        beerOutlinePath.addLine(to: topLeft)
        
        beerOutlinePath.move(to: CGPoint(x: widthPartition * 2, y: (heightPartition * 3) - handleRadius))
        beerOutlinePath.addLine(to: CGPoint(x: (widthPartition * 2) + handleRadius, y: (heightPartition * 3)))
        
        beerOutlinePath.addLine(to: CGPoint(x: (widthPartition * 3) - handleRadius, y: heightPartition * 3))
        beerOutlinePath.addLine(to: CGPoint(x: (widthPartition * 3), y: (heightPartition * 3) - handleRadius))
        
        beerOutlinePath.addLine(to: CGPoint(x: widthPartition * 3, y: (heightPartition * 1.5) + handleRadius))
        beerOutlinePath.addLine(to: CGPoint(x: (widthPartition * 3) - handleRadius, y: (heightPartition * 1.5)))
        
        beerOutlinePath.addLine(to: CGPoint(x: (widthPartition * 2) + handleRadius, y: (heightPartition * 1.5)))
        beerOutlinePath.addLine(to: CGPoint(x: (widthPartition * 2), y: (heightPartition * 1.5) + handleRadius))
        
        var inversedHandlePath = Path()
        
        inversedHandlePath.move(to: CGPoint(x: widthPartition * 2 + handleThickness, y: ((heightPartition * 3) - innerHandleRadius) - handleThickness))
        inversedHandlePath.addLine(to: CGPoint(x: (widthPartition * 2) + innerHandleRadius + handleThickness, y: (heightPartition * 3) - handleThickness))
        
        inversedHandlePath.addLine(to: CGPoint(x: (widthPartition * 3) - innerHandleRadius - handleThickness, y: heightPartition * 3 - handleThickness))
        inversedHandlePath.addLine(to: CGPoint(x: (widthPartition * 3) - handleThickness, y: (heightPartition * 3) - innerHandleRadius - handleThickness))
        
        inversedHandlePath.addLine(to: CGPoint(x: widthPartition * 3 - handleThickness, y: (heightPartition * 1.5) + innerHandleRadius + handleThickness))
        inversedHandlePath.addLine(to: CGPoint(x: (widthPartition * 3) - innerHandleRadius - handleThickness, y: (heightPartition * 1.5) + handleThickness))
        
        inversedHandlePath.addLine(to: CGPoint(x: (widthPartition * 2) + innerHandleRadius + handleThickness, y: (heightPartition * 1.5) + handleThickness))
        inversedHandlePath.addLine(to: CGPoint(x: (widthPartition * 2) + handleThickness, y: (heightPartition * 1.5) + innerHandleRadius + handleThickness))
        
        inversedHandlePath.closeSubpath()
        
        beerOutlinePath.addPath(inversedHandlePath.reversed)
        
        beerOutlinePath.closeSubpath()

        return beerOutlinePath

    }
}

struct PintView: View {
    
    @State var controlPoint: CGFloat = 225
    
    var midPoint1: CGFloat {
        return controlPoint - 30
    }
    var midPoint2: CGFloat {
        return controlPoint
    }
    var midPoint3: CGFloat {
        return controlPoint
    }
    
    @State var curveHeight1: CGFloat = 10
    @State var curveHeight2: CGFloat = 25
    @State var curveHeight3: CGFloat = -25
    
    @State var isAnimating1: Bool = false
    @State var isAnimating2: Bool = false
    @State var isAnimating3: Bool = false
    
    @State var isLabel1Visible: Bool = false
    @State var isLabel2Visible: Bool = false
    @State var isLabel3Visible: Bool = false
    
    var body: some View {
        ZStack() {
            GeometryReader { geo in
                
                ZStack {
                    
                    Pint()
                        .fill(Color.mediumBlue)
                        .frame(width: 200, height: 225)
                        .offset(x: 30)
                        
                    
                    ZStack() {
                        LiquidView(midPoint: midPoint1, curveHeight: $curveHeight1, isAnimating: $isAnimating1, animationDuration: 5)
                            .foregroundColor(.white)
                        .onAppear() {
                            isAnimating1 = true
                        }
                            .opacity(1)
                        
                        LiquidView(midPoint: midPoint2, curveHeight: $curveHeight2, isAnimating: $isAnimating2, animationDuration: 3)
                            .foregroundColor(.beer1)
                        .onAppear() {
                            isAnimating2 = true
                        }.opacity(0.5)

                        LiquidView(midPoint: midPoint3, curveHeight: $curveHeight3, isAnimating: $isAnimating3, animationDuration: 3)
                            .foregroundColor(.beer2)
                        .onAppear() {
                            isAnimating3 = true
                        }.opacity(0.25)
                    }.offset(x: 30)
                    .frame(width: 200, height: 225)
                    .mask(Pint().offset(x: 30))
                    .onAppear() {
                        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: { timer in
                            
                            if self.controlPoint >= -20 {
                                self.controlPoint -= 1
                            } else {
                                
                                // perform the label entrances
                                self.isLabel1Visible = true
                                self.isLabel2Visible = true
                                self.isLabel3Visible = true
                            }
                            
                        })
                    }
                    
                    VStack {
                        Text("Keep Calm")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.offWhite)
                            .padding(.top, 200)
                            .opacity(isLabel1Visible ? 1 : 0)
                            .animation(Animation.easeInOut(duration: 0.5))
                        
                        Spacer()
                        
                        Text("&")
                            .font(.title)
                            .foregroundColor(.offBlack)
                            .background(
                                Circle()
                                    .fill(Color.offWhite)
                                    .frame(width: 50, height: 50)
                                    .background(Circle().fill(Color.mediumBlue).frame(width: 57, height: 57))
                                    )
                            .opacity(isLabel2Visible ? 1 : 0)
                            .animation(Animation.easeInOut(duration: 0.5).delay(0.5))
                        
                        Spacer()
                        
                        Text("Have a Pint")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.offWhite)
                            .padding(.bottom, 200)
                            .opacity(isLabel3Visible ? 1 : 0)
                            .animation(Animation.easeInOut(duration: 0.5).delay(1))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
            }

            .navigationBarTitle(Text("Pint Loader"), displayMode: .inline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
    
    
    
}

struct LiquidView: View {
    
    var midPoint: CGFloat
    @Binding var curveHeight: CGFloat
    @Binding var isAnimating: Bool
    var animationDuration: Double
    
    var body: some View {
        GeometryReader { geo in
            Path { path in
                path.move(to: CGPoint(x: 0, y: midPoint))
                path.addLine(to: CGPoint(x: 0, y: geo.size.height))
                path.addLine(to: CGPoint(x: geo.size.width * 2, y: geo.size.height))
                path.addLine(to: CGPoint(x: geo.size.width * 2, y: midPoint))
                
                let controlPoint3 = CGPoint(x: geo.size.width * 0.5, y: midPoint + curveHeight)
                let controlPoint4 = CGPoint(x: geo.size.width * 0.5, y: midPoint - curveHeight)
                
                let controlPoint1 = CGPoint(x: geo.size.width * 1.5, y: midPoint + curveHeight)
                let controlPoint2 = CGPoint(x: geo.size.width * 1.5, y: midPoint - curveHeight)
                
                path.addCurve(to: CGPoint(x: geo.size.width, y: midPoint), control1: controlPoint1, control2: controlPoint2)
                
                path.addCurve(to: CGPoint(x: 0, y: midPoint), control1: controlPoint3, control2: controlPoint4)

                path.closeSubpath()
            }
            .offset(x: isAnimating ? -geo.size.width : 0, y: 0)
            .animation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: false))
        }
    }
}

struct PintView_Previews: PreviewProvider {
    static var previews: some View {
        PintView()
    }
}
