//
//  ObservedAndStateObjects.swift
//  SwiftUIFun
//
//  Created by Connor Black on 23/12/2020.
//

import SwiftUI

class CarViewModel: ObservableObject {
    init() {}
}

struct GarageView: View {
    
    // Garage View owns this car view model object since
    // it is initialised here.
    // Which means it should be a state object
    @StateObject var carViewModel = CarViewModel()
    
    var body: some View {
        CarView(viewModel: carViewModel)
    }
}

struct CarView: View {
    
    // CarView is passed a car view model in it's initialiser
    // and hence doesn't own the view model object.
    // Which means it should be an observed object.
    @ObservedObject var viewModel: CarViewModel
    
    var body: some View {
        Text("")
    }
}
