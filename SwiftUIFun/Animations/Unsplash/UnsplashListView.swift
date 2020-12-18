//
//  UnsplashListView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 18/12/2020.
//

import SwiftUI

let unsplashImageNames: [String] = ["unsplash-1", "unsplash-2", "unsplash-3", "unsplash-4", "unsplash-5", "unsplash-6", "unsplash-7", "unsplash-8", "unsplash-9", "unsplash-10", "unsplash-11"]

struct UnsplashListView: View {
    
    let imageNames: [String]
    
    @State var selectedImage: String?
    
    @Namespace var unsplashNamespace
    
    var body: some View {
        
            ZStack {
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        ForEach(imageNames, id: \.self) { imageName in
                            GeometryReader { geo in
                                VStack(alignment: .center) {
                                    
                                    Button(action: {
                                        withAnimation(Animation.spring()) {
                                            self.selectedImage = imageName
                                        }
                                        
                                    }, label: {
                                        Image(imageName)
                                            .resizable()
                                            .matchedGeometryEffect(id: imageName, in: unsplashNamespace)
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                            .frame(width: geo.size.width - 40, height: 250)
                                            .cornerRadius(20)
                                            .rotation3DEffect(Angle(degrees: Double((geo.size.height - (geo.frame(in: .named("ParentScrollView")).minY)) / 20)), axis: (x: -1, y: 0, z: 0))
                                            
                                    })
                                    
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                            }.frame(height: 250)
                        }
                        
                    }
                    .padding(.vertical)
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .blur(radius: selectedImage == nil ? 0 : 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .coordinateSpace(name: "ParentScrollView")
                
                
                if let image = selectedImage {
                    ZStack() {
                        VStack {
                            Spacer()
                            Image(image)
                                .resizable()
                                .cornerRadius(20)
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 20)
                                .matchedGeometryEffect(id: image, in: unsplashNamespace)
                                
                                
                                
                            
                            Spacer()
                        }
                    }
                    
                    .background(Color.offBlack.opacity(0.1))
                    .edgesIgnoringSafeArea(.bottom)
                    .onTapGesture {
                        withAnimation(Animation.spring()) {
                            selectedImage = nil
                        }
                    }
                }
                
            }
            
            .navigationBarHidden(false)
            .navigationBarTitle("Unsplash", displayMode: .inline)
    }
}

struct UnsplashListView_Previews: PreviewProvider {
    static var previews: some View {
        UnsplashListView(imageNames: unsplashImageNames)
    }
}
