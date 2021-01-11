//
//  FluidPageView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 07/01/2021.
//

import SwiftUI

struct FluidPageView: View {
    
    @State var sliderData = SliderData()
    @State var pageIndex = 0
    @State var sliderOffset: CGFloat = 0
    @State private var dragAmount: CGPoint?
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                content()
                slider(data: $sliderData)
            }
            .edgesIgnoringSafeArea(.vertical)
            .onAppear() {
                sliderData = SliderData(with: geo.size)
            }
        }
        
        .navigationBarTitle("Fluid Page View", displayMode: .inline)
    }
    
    func slider(data: Binding<SliderData>) -> some View {
        return ZStack {
            wave(data: data)
            button(data: data)
        }
        .offset(x: sliderOffset)
    }
    
    func content() -> some View {
        return Rectangle().foregroundColor(Config.colors[pageIndex])
    }
    
    func button(data: Binding<SliderData>) -> some View {
        let gesture = DragGesture()
            .onChanged {
                data.wrappedValue = data.wrappedValue.drag(value: $0)
                dragAmount = $0.location
            }
            .onEnded {
                if data.wrappedValue.isCancelled(value: $0) {
                    withAnimation(.spring(dampingFraction: 0.5)) {
                        data.wrappedValue = data.wrappedValue.initial()
                        dragAmount = data.wrappedValue.defaultButtonPosition
                    }
                } else {
                    self.swipe(data: data)
                }
            }
            .simultaneously(with:
                                TapGesture()
                                    .onEnded {
                                        self.swipe(data: data)
                                    }
            )
        
        return ZStack {
            
            let color = Config.colors[index(of: data.wrappedValue)]
            
            Circle().stroke(color)
                .frame(width: CGFloat(Config.buttonHeight), height: CGFloat(Config.buttonHeight))
            
            Image(systemName: "arrow.left")
                .frame(width: CGFloat(Config.buttonHeight / 2), height: CGFloat(Config.buttonHeight / 2))
                .foregroundColor(color)
            
        }
        .offset(x: sliderOffset)
        .position(dragAmount ?? data.wrappedValue.defaultButtonPosition)
        .opacity(data.wrappedValue.buttonOpacity)
        .gesture(gesture)
    }
    
    func wave(data: Binding<SliderData>) -> some View {
        return WaveView(data: data.wrappedValue)
            .foregroundColor(Config.colors[index(of: data.wrappedValue)])
    }
    
    private func swipe(data: Binding<SliderData>) {
        withAnimation() {
            data.wrappedValue = data.wrappedValue.final()
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            pageIndex = index(of: data.wrappedValue)
            sliderData = sliderData.initial()
            
            dragAmount = data.wrappedValue.defaultButtonPosition
            
            sliderOffset = 200
            withAnimation(.spring(dampingFraction: 0.5)) {
                sliderOffset = 0
            }
        }
    }
    
    private func index(of data: SliderData) -> Int {
        let last = Config.colors.count - 1
        return pageIndex == last ? 0 : pageIndex + 1
    }
    
}

struct FluidPageView_Previews: PreviewProvider {
    static var previews: some View {
        FluidPageView()
    }
}
