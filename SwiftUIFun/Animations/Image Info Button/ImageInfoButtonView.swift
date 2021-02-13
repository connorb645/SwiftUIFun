//
//  ImageInfoButtonView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 20/01/2021.
//

import SwiftUI

struct ImageInfoButtonView: View {
    
    @State var isExpanded = false
        
    let buttonSize: CGFloat = 35 // Width and height of the info button.
    
    var cornerRadius: CGFloat {
        return buttonSize / 2
    }
    
    let namespaceId = "imageOverlay"
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            ZStack {
                GeometryReader { geo in
                    ZStack {
                        // Image
                        
                        Image("unsplash-10")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width - (buttonSize * 1.7), height: geo.size.height - (buttonSize * 1.7))
                            .cornerRadius(35 / 2)
                        
                        // info overlay
                        
                        if isExpanded {
                            
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(Color.pink)
                                .overlay(FakeContentView().padding())
                                .matchedGeometryEffect(id: namespaceId, in: namespace)
                                .onTapGesture {
                                    withAnimation {
                                        isExpanded.toggle()
                                    }
                                }
                            
                        } else {
                            Button(action: {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }, label: {
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .fill(Color.pink)
                                    .matchedGeometryEffect(id: namespaceId, in: namespace)
                                    .overlay(Image(systemName: "info").foregroundColor(.white))
                                    .frame(width: buttonSize, height: buttonSize)
                                    .position(x: geo.size.width - (buttonSize / 2), y: buttonSize / 2)
                            })
                        }
                    }
                }
            }
            .frame(width: 350, height: 200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.offBlack)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageInfoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ImageInfoButtonView()
    }
}
