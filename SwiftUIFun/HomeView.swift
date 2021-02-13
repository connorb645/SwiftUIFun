//
//  ContentView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 10/12/2020.
//

import SwiftUI

struct HomeView: View {
    
    enum Section: CaseIterable {
        case threeDotsLoader, navigationDrawer, pint, unsplash, uiDesignPro, percentageDisplayView, floatingActionButton, christmasMessage, instagramClone,
            dotMorphingLoader, leftNavigationDrawer, fluidPageView, backgroundLightFlickering, dismissableNavigation, downButton
        
        var title: String {
            switch self {
            case .threeDotsLoader:
                return "Three Dots Loader"
            case .navigationDrawer:
                return "Navigation Drawer"
            case .pint:
                return "Pint Loader"
            case .unsplash:
                return "Unsplash"
            case .percentageDisplayView:
                return "Percentage View"
            case .uiDesignPro:
                return "@uidesign.pro"
            case .floatingActionButton:
                return "Floating Action Button"
            case .christmasMessage:
                return "Animated Christmas Lights Message"
            case .instagramClone:
                return "Instagram Clone"
            case .dotMorphingLoader:
                return "Dot Morphing Loader"
            case .leftNavigationDrawer:
                return "Left Navigation Drawer"
            case .fluidPageView:
                return "Fluid Page View"
            case .backgroundLightFlickering:
                return "Lightly Flickering Background"
            case .dismissableNavigation:
                return "Dismissable Navigation"
            case .downButton:
                return "Down Button"
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
            case .navigationDrawer:
                NavigationDrawerView()
            case .pint:
                PintView()
            case .unsplash:
                UnsplashListView()
            case .percentageDisplayView:
                PercentageDisplayView()
            case .uiDesignPro:
                UIDPHomeView()
            case .floatingActionButton:
                FloatingActionButtonContainerView()
            case .christmasMessage:
                MerryChristmasView()
            case .instagramClone:
                InstagramCloneView()
            case .dotMorphingLoader:
                DotMorphingLoaderContainerView()
            case .leftNavigationDrawer:
                LeftNavigationDrawer()
            case .fluidPageView:
                FluidPageView()
            case .backgroundLightFlickering:
                FlickeringLogInView()
            case .dismissableNavigation:
                DismissableNavigationView()
            case .downButton:
                DownButtonView()
         }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
