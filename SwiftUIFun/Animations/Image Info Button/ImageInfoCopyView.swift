//
//  ImageInfoCopyView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 21/01/2021.
//

import SwiftUI

struct ImageInfoCopyView: View {
    
    @State var isExpanded = false
    
    let buttonSize: CGFloat = 35
    var cornerRadius: CGFloat {
        buttonSize / 2
    }
    
    @Namespace var namespace
    var body: some View {
        ZStack {
            ZStack {
                GeometryReader { geo in
                    ZStack {
                        Image("unsplash-10")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width - buttonSize * 1.7, height: geo.size.height - buttonSize * 1.7 )
                            .cornerRadius(cornerRadius)
                            .clipped()
                        
                        if (isExpanded) {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(Color.pink)
                                .overlay(FakeContentView().padding())
                                .matchedGeometryEffect(id: "imageOverlay", in: namespace)
                                .onTapGesture {
                                    withAnimation(Animation.default) {
                                        isExpanded.toggle()
                                    }
                                }
                            
                        } else {
                            Button(action: {
                                withAnimation(Animation.default) {
                                    isExpanded.toggle()
                                }
                            }, label: {
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .fill(Color.pink)
                                    .matchedGeometryEffect(id: "imageOverlay", in: namespace)
                                    .overlay(Image(systemName: "info").foregroundColor(.white))
                                    .frame(width: buttonSize, height: buttonSize)
                                    .position(x: geo.size.width - (buttonSize / 2), y: buttonSize / 2)
                                
                                
                            })
                            
                        }
                    }
                    
                }
                .frame(width: 350, height: 250)
                
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.offBlack)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageInfoCopyView_Previews: PreviewProvider {
    static var previews: some View {
        ImageInfoCopyView()
    }
}
