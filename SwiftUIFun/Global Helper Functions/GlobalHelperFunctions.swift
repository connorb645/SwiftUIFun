//
//  GlobalHelperFunctions.swift
//  SwiftUIFun
//
//  Created by Connor Black on 31/01/2021.
//

import SwiftUI

func runCounter<T: FloatingPoint>(counter: Binding<T>, start: T, end: T, increment: T, speed: Double) {
    
    counter.wrappedValue = start
    
    Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
        counter.wrappedValue += increment
        if counter.wrappedValue >= end {
            timer.invalidate()
        }
    }
}


func delay(_ seconds: Double, _ action: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        action()
    }
}
