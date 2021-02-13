//
//  BottomDockViewCopy.swift
//  SwiftUIFun
//
//  Created by Connor Black on 10/02/2021.
//

import SwiftUI
import Combine

struct SearchBarViewCopy: View {
    
    @ObservedObject private var viewModel = SearchBarViewModelCopy()
    
    var body: some View {
        ZStack {
            Color.offBlack.edgesIgnoringSafeArea(.all)
            ZStack {
                ZStack {
                    GeometryReader { geo in
                        VStack(spacing: 1) {
                            HStack(spacing: 1) {
                                
                                searchButton(geo: geo)
                                
                                textField
                                
                            }
                            
                            resultsView
                            
                        }
                    }
                    
                }
                .frame(height: 50)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    func searchButton(geo: GeometryProxy) -> some View {
        return Button(action: {
            viewModel.isButtonAnimated.toggle()

            delay(0.25) {
                viewModel.isSearchBarVisible.toggle()
            }
        
        }, label: {
            Rectangle()
                .fill(Color.offWhite)
                .overlay(
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 25, height: 25)
                )
                
        })
        .foregroundColor(.offBlack)
        .frame(width: 50, height: 50)
        .offset(x: viewModel.isButtonAnimated ? 0.0 : (geo.size.width * 0.5) - 25)
        .zIndex(1)
        .animation(.linear)
    }
    
    var textField: some View {
        TextField("search here", text: $viewModel.searchText)
            .frame(height: 50)
            .padding(.horizontal)
            .background(Color.offWhite)
            .rotation3DEffect(
                .init(degrees: viewModel.searchRotation),
                axis: (x: 0.0, y: 1.0, z: 0.0),anchor: .leading)
            .animation(.linear)
    }
    
    var resultsView: some View {
        Rectangle()
            .fill(Color.offWhite)
            .frame(height: 150)
            .overlay(FakeContentView())
            .rotation3DEffect(.init(degrees: viewModel.resultsRotation), axis: (x: 1.0, y: 0.0, z: 0.0), anchor: .top)
            .animation(.linear)
    }
}

class SearchBarViewModelCopy: ObservableObject {
    
    var cancelBag = Set<AnyCancellable>()
    
    @Published var searchText = ""
    
    @Published var isButtonAnimated = false
    
    @Published var isSearchBarVisible = false
    
    @Published var isResultsVisible = false
                
    var searchRotation: Double {
        isSearchBarVisible ? 0.0 : 90.0
    }
    
    var resultsRotation: Double {
        isResultsVisible ? 0.0 : -90.0
    }
    
    func buttonOffset(geo: GeometryProxy) -> CGFloat {
        isButtonAnimated ? 0.0 + 25 : (geo.size.width * 0.5)
    }
    
    func lineOffset(geo: GeometryProxy) -> CGPoint {
        if isButtonAnimated {
            return .init(x: geo.size.width, y: geo.size.height)
        } else {
            return .init(x: geo.size.width * 0.55, y: geo.size.height * 0.6)
        }
    }
    
    init() {
        $searchText
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                if text == "" {
                    self?.isResultsVisible = false
                } else {
                    self?.isResultsVisible = true
                }
            }
            .store(in: &cancelBag)
    }
}

struct SearchBarViewCopy_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarViewCopy()
    }
}
