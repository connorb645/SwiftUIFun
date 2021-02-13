//
//  LeftNavigationDrawer.swift
//  SwiftUIFun
//
//  Created by Connor Black on 04/01/2021.
//

import SwiftUI

enum LNDScreen {
    case swift, python, kotlin
    
    var title: String {
        switch self {
        case .swift:
            return "Learn Swift"
        case .python:
            return "Learn Python"
        case .kotlin:
            return "Learn Kotlin"
        }
    }
}

struct LeftNavigationDrawer: View {
        
    @State var isNavigationDrawerOpen = false
    @State var selectedScreen: LNDScreen = .swift
    
    var body: some View {
        ZStack {
            Color.offBlack
                .edgesIgnoringSafeArea(.all)
                        
            LNDNavigationView(isNavigationDrawerOpen: $isNavigationDrawerOpen, selectedScreen: $selectedScreen)
            
            VStack {
                switch selectedScreen {
                case .swift:
                    LNDFakeScreen(title: selectedScreen.title, isNavigationDrawerOpen: $isNavigationDrawerOpen)
                        .transition(.move(edge: .trailing))
                case .python:
                    LNDFakeScreen(title: selectedScreen.title, isNavigationDrawerOpen: $isNavigationDrawerOpen)
                        .transition(.move(edge: .trailing))
                case .kotlin:
                    LNDFakeScreen(title: selectedScreen.title, isNavigationDrawerOpen: $isNavigationDrawerOpen)
                        .transition(.move(edge: .trailing))
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LNDPrimaryButton: View {
    var body: some View {
        Button(action: { print("Go to search") }, label: {
            RoundedRectangle(cornerRadius: 15)
            .fill(Color.pink)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .overlay(HStack {
                Text("Search")
                Image(systemName: "arrow.right")
            })
            
        })
    }
}

struct LNDNavigationView: View {
    
    @Binding var isNavigationDrawerOpen: Bool
    @Binding var selectedScreen: LNDScreen
        
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Spacer()
                    
                    LNDRoundedIconButton(image: Image(systemName: "arrow.left"), backgroundColour: Color.offWhite.opacity(0.1), isIcon: true) {
                        isNavigationDrawerOpen.toggle()
                    }
                }
                
                LNDProfileImageView()
                
                LNDProfileNameView()
                
                LNDListView(selectedScreen: $selectedScreen, isNavigationDrawerOpen: $isNavigationDrawerOpen)
                
                LNDPrimaryButton()
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 40)
            .foregroundColor(.white)
           
            .navigationBarHidden(true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.trailing, 80)
    }
}

struct LNDProfileImageView: View {
    var body: some View {
        Button(action: {}, label: {
            HStack {
                Image("portrait")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .scaledToFill()
                    
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .strokeBorder(Color.offBlack, lineWidth: 7)
                            
                    )
                    .overlay(
                        Circle()
                            .strokeBorder(Color.pink, lineWidth: 3)
                            
                    )
                                
                Spacer()
            }
        })
    }
}

struct LNDProfileNameView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Connor Black")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.pink)
                    .frame(width: 100, height: 6)
                    
            }
            
            Spacer()
        }
    }
}

struct LNDListView: View {
    
    @Binding var selectedScreen: LNDScreen
    @Binding var isNavigationDrawerOpen: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Button(action: {
                
                if selectedScreen == .swift {
                    isNavigationDrawerOpen.toggle()
                } else {
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { timer in
                        isNavigationDrawerOpen.toggle()
                    }
                }
                
                withAnimation {
                    selectedScreen = .swift
                }
                
            }, label: {
                LNDListItemView(iconName: "swift-logo", title: "Learn Swift")
            })
            
            Button(action: {
                if selectedScreen == .python {
                    isNavigationDrawerOpen.toggle()
                } else {
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { timer in
                        isNavigationDrawerOpen.toggle()
                    }
                }
                
                withAnimation {
                    selectedScreen = .python
                }
            }, label: {
                LNDListItemView(iconName: "python-logo", title: "Learn Python")
            })
            
            Button(action: {
                if selectedScreen == .kotlin {
                    isNavigationDrawerOpen.toggle()
                } else {
                    Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { timer in
                        isNavigationDrawerOpen.toggle()
                    }
                }
                
                withAnimation {
                    selectedScreen = .kotlin
                }
            }, label: {
                LNDListItemView(iconName: "kotlin-logo", title: "Learn Kotlin")
            })
            
        }
        .padding(.vertical, 30)
    }
}

struct LNDListItemView: View {
    
    let iconName: String
    let title: String
    
    var body: some View {
        HStack {
            
            LNDRoundedIconButton(image: Image(iconName), backgroundColour: Color.offWhite, isIcon: false) {
                print("List Item Tapped...")
            }
            
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Spacer()
            
            Image(systemName: "arrow.right")
        }
    }
}

struct LNDRoundedIconButton: View {
    
    let image: Image
    let backgroundColour: Color
    let isIcon: Bool
    let action: () -> ()
    
    var body: some View {
        Button(action: action, label: {
            RoundedRectangle(cornerRadius: 12.5)
                .fill(backgroundColour)
                .frame(width: 45, height: 45)
                .overlay(
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: isIcon ? 20 : 32.5, height: isIcon ? 20 : 32.5)
                )
        })
    }
}

struct LNDScreenFakeNavigationBar: View {
    
    @Binding var isNavigationDrawerOpen: Bool
    let title: String
    
    var body: some View {
        HStack {
            LNDRoundedIconButton(image: Image(systemName: "line.horizontal.3.decrease"), backgroundColour: Color.offBlack.opacity(0.07), isIcon: true) {
                isNavigationDrawerOpen.toggle()
            }
            .accentColor(.offBlack)
            .offset(y: 10)
            
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.offBlack)
                .padding()
                .offset(y: 10)
            
            Spacer()
        }
        .padding(30)
        .background(Color.offWhite)
    }
}

struct LNDFakeScreen: View {
    
    let title: String
    @Binding var isNavigationDrawerOpen: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                
                LNDScreenFakeNavigationBar(isNavigationDrawerOpen: $isNavigationDrawerOpen, title: title)
                
                ScrollView {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.offWhite)
                        .frame(height: 300)
                        .overlay(FakeContentView(rowCount: 7, rowColor: .white))
                        .padding()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.offWhite)
                        .frame(height: 300)
                        .overlay(FakeContentView(rowCount: 7, rowColor: .white))
                        .padding()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.offWhite)
                        .frame(height: 300)
                        .overlay(FakeContentView(rowCount: 7, rowColor: .white))
                        .padding()
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(isNavigationDrawerOpen ? 30 : 0)
            .offset(x: isNavigationDrawerOpen ? geo.size.width - 60 : 0)
            .scaleEffect(isNavigationDrawerOpen ? 0.8 : 1.0)
            .animation(Animation.spring())
            .edgesIgnoringSafeArea(.all)
        }
    }
    
}

struct LeftNavigationDrawer_Previews: PreviewProvider {
    static var previews: some View {
        LeftNavigationDrawer()
    }
}
