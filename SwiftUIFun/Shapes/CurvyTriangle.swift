//
//  CurvyTriangle.swift
//  SwiftUIFun
//
//  Created by Connor Black on 31/01/2021.
//

import SwiftUI

struct CurvyTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        let leftCP1 = CGPoint(x: rect.width * 0.4, y: rect.height * 0.4)
        let leftCP2 = CGPoint(x: rect.width * 0.3, y: rect.height * 0.6)
        
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                      control1: leftCP1,
                      control2: leftCP2)
        
        let bottomCP1 = CGPoint(x: rect.width * 0.4, y: rect.height * 1.8)
        let bottomCP2 = CGPoint(x: rect.width * 0.6, y: rect.height * 1.8)
        
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY),
                      control1: bottomCP1,
                      control2: bottomCP2)
        
        let rightCP1 = CGPoint(x: rect.width * 0.7, y: rect.height * 0.6)
        let rightCP2 = CGPoint(x: rect.width * 0.6, y: rect.height * 0.4)
        
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY),
                      control1: rightCP1,
                      control2: rightCP2)

        return path
    }
}
