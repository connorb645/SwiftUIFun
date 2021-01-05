//
//  DotMorphingLoader.swift
//  SwiftUIFun
//
//  Created by Connor Black on 02/01/2021.
//

import SwiftUI

struct DotMorphingLoaderContainerView: View {
    
    @State var contentHasLoaded = false
    @State var isLoading = false
    @State var showMoreContent = false
    
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                if contentHasLoaded {
                    
                    VStack(spacing: 25) {
                        Spacer(minLength: 100)
                        HStack(spacing: 25) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                                .overlay(FakeContentView())
                                .matchedGeometryEffect(id: "blue", in: namespace)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.yellow)
                                .overlay(FakeContentView())
                                .matchedGeometryEffect(id: "yellow", in: namespace)
                                
                        }.zIndex(2.0)
                        
                        HStack(spacing: 25)  {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.red)
                                .overlay(FakeContentView())
                                .matchedGeometryEffect(id: "red", in: namespace)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green)
                                .overlay(FakeContentView())
                                .matchedGeometryEffect(id: "green", in: namespace)
                                
                        }.zIndex(1.0)
                        
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.clear)
                            .frame(height: 300)
                            .overlay(FakeContentView(rowCount: 6))
                            .opacity(showMoreContent ? 1.0 : 0.0)
                            .animation(Animation.easeInOut(duration: 0.5).delay(0.33))
                        
                    }
                    .padding()
                    .onAppear {
                        showMoreContent.toggle()
                    }
                    
                } else {
                    DotMorphingLoaderView(animationTurnedOn: $isLoading, namespace: namespace)
                        .frame(width: 50, height: 50)
                }
                Spacer()
                HStack {
                    Button(action: {
                        contentHasLoaded = false
                        isLoading = false
                        showMoreContent = false
                    }, label: {
                        Text("Reset")
                    })
                    .foregroundColor(Color.offWhite)
                    .padding()
                    
                    Button(action: {
                        isLoading.toggle()
                        if !isLoading {
                            withAnimation(Animation.spring()) {
                                contentHasLoaded.toggle()
                            }
                        }
                    }, label: {
                        Text("\(isLoading ? "Finish" : "Start") Loading")
                    })
                    .foregroundColor(Color.offWhite)
                    .padding()
                    
                }
                .padding(.bottom, 45)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
        }
        .navigationBarTitle(Text("Dot Morphing Loader"), displayMode: .inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.offBlack)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct DotMorphingLoaderView: View {
    
    @State var spinning = false
    @Binding var animationTurnedOn: Bool
    
    var namespace: Namespace.ID
    
    @State var timer: Timer?
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                
                // Draw a circle for the frame
                Circle()
                    .fill(Color.clear)
                
                Circle()
                    .fill(Color.blue)
                    .matchedGeometryEffect(id: "blue", in: namespace)
                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    .offset(x: -geo.size.width / 3, y: -geo.size.width / 3)
                    .rotationEffect(.degrees(spinning ? 0 : -360))
                
                Circle()
                    .fill(Color.yellow)
                    .matchedGeometryEffect(id: "yellow", in: namespace)
                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    .offset(x: geo.size.width / 3, y: -geo.size.width / 3)
                    .rotationEffect(.degrees(spinning ? 0 : -360))

                Circle()
                    .fill(Color.green)
                    .matchedGeometryEffect(id: "green", in: namespace)
                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    .offset(x: geo.size.width / 3, y: geo.size.width / 3)
                    .rotationEffect(.degrees(spinning ? 0 : -360))

                Circle()
                    .fill(Color.red)
                    .matchedGeometryEffect(id: "red", in: namespace)
                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    .offset(x: -geo.size.width / 3, y: geo.size.width / 3)
                    .rotationEffect(.degrees(spinning ? 0 : -360))
            }
            .onAppear {
                if timer == nil {
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        if animationTurnedOn {
                            spinning = false
                            withAnimation(Animation.linear(duration: 1.0)) {
                                spinning.toggle()
                            }
                        }
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
        
    }
}

struct FakeContentView: View {
    
    var rowCount: Int = 4
    
    var rowColor: Color = .white
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<rowCount) { rowNumber in
                    if rowNumber == 0 {
                        Rectangle()
                            .fill(rowColor.opacity(0.3))
                            .frame(width: geo.size.width * 0.50)
                    } else {
                        Rectangle().fill(rowColor.opacity(0.3))
                    }
                }
            }
            .padding()
        }
    }
}

struct DotMorphingLoaderContainerView_Previews: PreviewProvider {
    static var previews: some View {
        DotMorphingLoaderContainerView()
    }
}
