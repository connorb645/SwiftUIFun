//
//  View+Extension.swift
//  SwiftUIFun
//
//  Created by Connor Black on 02/01/2021.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>
        (_ condition: Bool, if ifTransform: (Self) -> TrueContent,
        else elseTransform: (Self) -> FalseContent) -> some View {
        
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
    
    @ViewBuilder
    func ifLet<V, Transform: View>
        (_ value: V?, transform: (Self, V) -> Transform) -> some View {
        
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}
