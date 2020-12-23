//
//  FloatingActionButton.swift
//  SwiftUIFun
//
//  Created by Connor Black on 22/12/2020.
//

import SwiftUI

struct FloatingActionButtonContainerView: View {
    
    enum Side {
        case top, right, bottom, left
    }
    
    enum Screen: CaseIterable {
        case screenOne, screenTwo, screenThree
        
        var title: String {
            switch self {
            case .screenOne:
                return "Screen One"
            case .screenTwo:
                return "Screen Two"
            case .screenThree:
                return "Screen Three"
            }
        }
        
        var description: String {
            switch self {
            case .screenOne:
                return "Show any content relating to screen one that you wish."
            case .screenTwo:
                return "Show any content relating to screen two that you wish."
            case .screenThree:
                return "Show any content relating to screen three that you wish."
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .screenOne:
                return Color.lightLime
            case .screenTwo:
                return Color.lightOrange
            case .screenThree:
                return Color.lightSalmon
            }
        }
    }
    
    @State private var dragAmount: CGPoint?
    @State private var isShowingMenu = false
    @State private var selectedScreen: Screen = .screenOne
    
    @Namespace var namespace
    
    let buttonWidth: CGFloat = 75
    let buttonPadding: CGFloat = 10
    
    var buttonAdjustment: CGFloat {
        return (buttonWidth / 2) + buttonPadding
    }
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Text(selectedScreen.description)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.offBlack)
                    .padding()
                                
                Spacer()
                
                .navigationTitle(selectedScreen.title)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(selectedScreen.backgroundColor)
                
            VStack {
                if isShowingMenu {
                    ZStack(alignment: .topTrailing) {
                        VStack {
                            
                            ForEach(Screen.allCases, id:\.self) { screen in
                                Button(action: {
                                    withAnimation(.spring()) {
                                        selectedScreen = screen
                                        isShowingMenu.toggle()
                                    }
                                }) {
                                    Text(screen.title)
                                        .padding()
                                        .frame(height: 60)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                }
                                .accentColor(.offBlack)
                            }

                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.offWhite)
                        .cornerRadius(20)
                        .padding(20)
                        
                        FloatingButtonView() {
                            withAnimation(.spring()) {
                                isShowingMenu.toggle()
                            }
                        }
                        .rotationEffect(Angle(degrees: 45))
                        .matchedGeometryEffect(id: "addButton", in: namespace)
                        .frame(width: buttonWidth * 0.75, height: buttonWidth * 0.75)
                        
                                                
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    GeometryReader { geo in
                        FloatingButtonView {
                            withAnimation(.spring()) {
                                isShowingMenu.toggle()
                            }
                        }
                        .matchedGeometryEffect(id: "addButton", in: namespace)
                        .frame(width: buttonWidth * 1.25, height: buttonWidth * 1.25)
                        .shadow(radius: 20)
                        .position(dragAmount ?? defaultPosition(geo: geo))
                        .highPriorityGesture(
                            DragGesture()
                                .onChanged { value in
                                    dragAmount = value.location
                                    print(value)
                                }
                                .onEnded { value in
                                    
                                    withAnimation(Animation.interpolatingSpring(stiffness: 1000, damping: 20, initialVelocity: 5)) {
                                        
                                        switch closestSide(geoSize: geo.size, location: value.predictedEndLocation) {
                                        case .top:
                                            dragAmount?.y = 0 + buttonAdjustment
                                        case .right:
                                            dragAmount?.x = geo.size.width - buttonAdjustment
                                        case .bottom:
                                            dragAmount?.y = geo.size.height - buttonAdjustment
                                        case .left:
                                            dragAmount?.x = 0 + buttonAdjustment
                                        }
                                    }
                                    
                                }
                        )
                    }
                    
                }
            }
        }
        
    }
    
    func closestSide(geoSize: CGSize, location: CGPoint) -> Side {
        
        typealias DirectionDistance = (side: Side, distance: CGFloat)
        
        let distanceFromTop: DirectionDistance = (side: .top, distance: location.y)
        let distanceFromRight: DirectionDistance = (side: .right, distance: geoSize.width - location.x)
        let distanceFromBottom: DirectionDistance = (side: .bottom, distance: geoSize.height - location.y)
        let distanceFromLeft: DirectionDistance = (side: .left, distance: location.x)
        
        let distances = [distanceFromTop, distanceFromRight, distanceFromBottom, distanceFromLeft]
        
        let sortedByDistances = distances.sorted { $0.distance < $1.distance }
        
        return sortedByDistances.first?.side ?? .right
    }
    
    func defaultPosition(geo: GeometryProxy) -> CGPoint {
        CGPoint(x: geo.size.width - buttonAdjustment, y: geo.size.height - buttonAdjustment)
    }
    
}

struct FloatingButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 15, height: 15)
            
        })
        .accentColor(.offWhite)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Circle().fill(Color.pink))
        .padding()
    }
}

struct FloatingActionButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingActionButtonContainerView()
    }
}
