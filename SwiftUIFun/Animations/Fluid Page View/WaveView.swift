//
//  WaveView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 07/01/2021.
//

import SwiftUI

struct WaveView: Shape {

    private var centerY: Double
    private var progress: Double

    init(data: SliderData) {
        self.centerY = data.centerY
        self.progress = data.progress
    }

    internal var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(centerY, progress) }
        set {
            centerY = newValue.first
            progress = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let data = SliderData(centerY: centerY, progress: progress, with: rect.size)
        let waveLedge = data.waveLedgeX
        let hr = data.waveHorizontalRadius
        let vr = data.waveVerticalRadius
        let curveStartY = vr + data.centerY
        
        let x: Double = data.width + 50
        path.move(to: CGPoint(x: waveLedge, y: 0))
        path.addLine(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x, y: data.height))
        path.addLine(to: CGPoint(x: waveLedge, y: data.height))
        path.addLine(to: CGPoint(x: waveLedge, y: curveStartY))
        
        let bottomCurveCP1 = CGPoint(x: waveLedge, y: curveStartY - (vr * 0.5))
        let bottomCurveCP2 = CGPoint(x: waveLedge - hr, y: curveStartY - (vr * 0.5))
        let topCurveCP1 = CGPoint(x: waveLedge - hr, y: curveStartY - (vr * 2) + (vr * 0.5))
        let topCurveCP2 = CGPoint(x: waveLedge, y: curveStartY - (vr * 2) + (vr * 0.5))
        
        path.addCurve(to: CGPoint(x: waveLedge - hr, y: curveStartY - vr),
                      control1: bottomCurveCP1,
                      control2: bottomCurveCP2)
        
        path.addCurve(to: CGPoint(x: waveLedge, y: curveStartY - (vr * 2)),
                      control1: topCurveCP1,
                      control2: topCurveCP2)
        
        path.closeSubpath()
        return path
    }

}
