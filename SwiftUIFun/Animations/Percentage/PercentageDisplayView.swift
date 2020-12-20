//
//  PercentageDisplayView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 20/12/2020.
//

import SwiftUI

struct PercentageDisplayView: View {
    
    let columns = [GridItem(.flexible(minimum: 50), spacing: 20),
                   GridItem(.flexible(minimum: 50), spacing: 20),
                   ]
    
    let percentages: [CGFloat] = [50, 60, 70, 80, 90, 100]
    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(percentages, id: \.self) { percentage in
                PercentageView(progress: percentage, lineWidth: 15, startColor: Color.lightGreen, endColor: .darkGreen, fontScale: .small)
                    .frame(width: 150, height: 150)
            }
        }.frame(maxHeight: .infinity)
        
        .navigationBarTitle(Text("Gradient Percentage Views"), displayMode: .inline)
    }
}

struct PercentageDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageDisplayView()
    }
}
