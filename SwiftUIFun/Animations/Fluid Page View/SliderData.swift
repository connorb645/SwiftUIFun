//
//  SliderData.swift
//  SwiftUIFun
//
//  Created by Connor Black on 07/01/2021.
//

import SwiftUI

struct Config {
    static let buttonHeight = 50.0
    static let buttonRadius = 24.0
    static let buttonMargin = 8.0
    static let arrowWidth = 4.0
    static let arrowHeight = 10.0
    static let swipeVelocity = 0.45
    static let swipeCancelThreshold = 0.15
    static let waveMinLedge = 15.0
    static let waveMinHR = 0.0
    static let waveMinVR = 82.0

    static let colors = [Color.offBlack, Color.mediumBlue, Color.darkGreen, Color.mediumGreen, Color.lightGreen]
}

struct SliderData {

    let centerY: Double
    let progress: Double
    let size: CGSize

    init(with size: CGSize = .zero) {
        self.init(centerY: 400, progress: 0, with: size)
    }

    init(centerY: Double, progress: Double, with size: CGSize = .zero) {
        self.centerY = centerY
        self.progress = progress
        self.size = size
    }
    
    var width: Double { Double(size.width) }
    
    var height: Double { Double(size.height) }

    var defaultButtonPosition: CGPoint {
        return .init(x: width - Config.buttonHeight, y: centerY)
    }

    var buttonOpacity: Double { max(1 - progress * 5, 0) }

    var waveLedgeX: Double {
        let ledge = Config.waveMinLedge.interpolate(to: width, in: progress, min: 0.2, max: 0.8)
        return width - ledge
    }

    var waveHorizontalRadius: Double {
        let p1: Double = 0.4
        let to = width * 0.8
        if progress <= p1 {
            return Config.waveMinHR.interpolate(to: to, in: progress, max: p1)
        } else if progress >= 1 {
            return to
        }
        let t = (progress - p1) / (1 - p1)
        let m: Double = 9.8
        let beta: Double = 40.0 / (2 * m)
        let omega = pow(-pow(beta, 2) + pow(50.0 / m, 2), 0.5)
        return to * exp(-beta * t) * cos(omega * t)
    }

    var waveVerticalRadius: Double { Config.waveMinVR.interpolate(to: height * 0.9, in: progress, max: 0.4) }

    func initial() -> SliderData { SliderData(centerY: centerY, progress: 0, with: size) }

    func final() -> SliderData { SliderData(centerY: centerY, progress: 1, with: size) }

    func drag(value: DragGesture.Value) -> SliderData {
        let dragX = (-1) * Double(value.translation.width)
        let progress = min(1.0, max(0, dragX * Config.swipeVelocity / width))
        return SliderData(centerY: Double(value.location.y), progress: progress, with: size)
    }

    func isCancelled(value: DragGesture.Value) -> Bool { drag(value: value).progress < Config.swipeCancelThreshold }
}


//extension Int {
//    func ff(_ shift: Int) -> Double {
//        return Double((self >> shift) & 0xff) / 255
//    }
//}

extension Double {
    func interpolate(to: Double, in fraction: Double, min: Double = 0, max: Double = 1) -> Double {
        if fraction <= min {
            return self
        } else if fraction >= max {
            return to
        }
        return self + (to - self) * (fraction - min) / (max - min)
    }
}
