//
//  LinearGradient+Extension.swift
//  SwiftUIFun
//
//  Created by Connor Black on 02/01/2021.
//

import SwiftUI

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
