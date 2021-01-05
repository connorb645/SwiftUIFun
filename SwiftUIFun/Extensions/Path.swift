//
//  Path.swift
//  SwiftUIFun
//
//  Created by Connor Black on 24/12/2020.
//

import SwiftUI

extension Path {
    func scaled(toFit rect: CGRect) -> Path {
        let scaleW = rect.width/boundingRect.width
        let scaleH = rect.height/boundingRect.height
        let scaleFactor = min(scaleW, scaleH)
        return applying(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
    }
}
