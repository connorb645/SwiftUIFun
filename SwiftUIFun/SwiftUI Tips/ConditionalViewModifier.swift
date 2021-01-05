//
//  ConditionalViewModifier.swift
//  SwiftUIFun
//
//  Created by Connor Black on 02/01/2021.
//

import SwiftUI

struct ConditionalViewModifier: View {
    var someCondition = false
    var someParameter: Int? = 1
    
    var body: some View {
        
        Circle()
            .fill(someCondition ? Color.black : Color.blue)
        
        Circle()
            .fill(Color.white)
            .if(someCondition) {
                $0.overlay(Circle().strokeBorder(Color.blue, lineWidth: 4))
            }
        
        Circle()
            .fill(Color.white)
            .if(someCondition) {
                $0.overlay(Circle().strokeBorder(Color.blue, lineWidth: 4))
            } else: {
                $0.overlay(Circle().fill(Color.blue))
            }
        
        Circle()
            .fill(Color.white)
            .ifLet(someParameter) {
                $0.overlay(Text("\($1)"))
            }
    }
}

struct ConditionalViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        ConditionalViewModifier()
    }
}
