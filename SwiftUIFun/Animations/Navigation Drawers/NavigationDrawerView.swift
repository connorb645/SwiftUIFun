//
//  NavigationDrawerView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 11/12/2020.
//

import SwiftUI

struct NavigationDrawerView: View {
    
    enum NavigationItem: Int, CaseIterable {
        case apple, home, person, settings
        
        var image: Image {
            switch self {
            case .apple:
                return Image(systemName: "applelogo")
            case .home:
                return Image(systemName: "house")
            case .person:
                return Image(systemName: "person")
            case .settings:
                return Image(systemName: "gearshape")
            }
        }
    }
    
    let drawerWidth: CGFloat = 80
    let padding: CGFloat = 10
    
    @State var isClosed = false
    @State var isFloating = false
    
    @State var selectedItem: NavigationItem = .apple
    
    var body: some View {
        ZStack {
            VStack {
                selectedItem.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.offWhite)
                    .padding(.top, 200)
                
                Spacer()
            }
            
            GeometryReader { geo in
                VStack {
                    ForEach(NavigationItem.allCases, id: \.self) { item in
                        
                        Button(action: {
                            self.selectedItem = item
                        }, label: {
                            item.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        })
                        .padding(.vertical, 20)
                        .foregroundColor(self.selectedItem == item ? .offBlack : .mediumBlue)
                        
                    }
                }
                .frame(width: drawerWidth, height: geo.size.height / 2.5)
                .background(RoundedRectangle(cornerRadius: 30).fill(Color.offWhite))
                .offset(x: isClosed ? geo.size.width : geo.size.width - drawerWidth - padding,
                        y: isFloating ? (geo.size.height / 1.7) + 3 : (geo.size.height / 1.7) - 3)
            }
            
            .navigationBarTitle(Text("Floating Navigation Drawer"), displayMode: .inline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.offBlack)
        .edgesIgnoringSafeArea(.all)
        .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification), perform: { _ in
            withAnimation(Animation.interpolatingSpring(stiffness: 200, damping: 8)) {
                self.isClosed.toggle()
            }
        })
        .onAppear() {
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                self.isFloating.toggle()
            }
        }
    }
}

struct NavigationDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDrawerView()
    }
}

extension NSNotification.Name {
    public static let deviceDidShakeNotification = NSNotification.Name("MyDeviceDidShakeNotification")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        NotificationCenter.default.post(name: .deviceDidShakeNotification, object: event)
    }
}
