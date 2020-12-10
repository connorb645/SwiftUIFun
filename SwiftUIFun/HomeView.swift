//
//  ContentView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 10/12/2020.
//

import SwiftUI

struct HomeView: View {
    
    enum Section: CaseIterable {
        case threeDotsLoader
        
        var title: String {
            switch self {
            case .threeDotsLoader:
                return "Three Dots Loader"
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Section.allCases, id: \.self) { section in
                    
                    NavigationLink(destination: containedView(section: section)) {
                        Text("\(section.title)")
                    }
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("SwiftUI Fun")
        }
    }
    
    func containedView(section: Section) -> some View {
        return ZStack {
            switch section {
            case .threeDotsLoader:
                ThreeDotsLoaderView()
         }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
