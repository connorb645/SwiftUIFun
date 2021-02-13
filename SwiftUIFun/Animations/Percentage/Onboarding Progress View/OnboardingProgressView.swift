//
//  OnboardingProgressView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 06/02/2021.
//

import SwiftUI

struct OnboardingProgressView: View {
    
    let colorStart: Color = Color.pink
    let colorEnd: Color = Color.orange
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var progress: CGFloat = 0.0
    
    var totalNumberOfQuestions: Int = 2
    
    var totalNumberOfAnsweredQuestions: Int {
        var total = 0
        
        if firstName != "" { total += 1 }
        
        if lastName != "" { total += 1 }
        
        return total
    }
    
    var body: some View {
        ZStack {
            Color.offBlack.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    progressView
                                        
                    firstNameTextField
                                        
                    lastNameTextField
                }
                .padding()
                .onChange(of: firstName, perform: { value in
                    progress = CGFloat(totalNumberOfAnsweredQuestions) / CGFloat(totalNumberOfQuestions)
                })
                .onChange(of: lastName, perform: { value in
                    progress = CGFloat(totalNumberOfAnsweredQuestions) / CGFloat(totalNumberOfQuestions)
                })
            }
        }
    }
    
    var firstNameTextField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your first name:")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            TextField("e.g. John", text: $firstName)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color.offWhite.opacity(0.2))
                .cornerRadius(10)
        }
        .foregroundColor(.offWhite)
    }
    
    var lastNameTextField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your last name:")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            TextField("e.g. Smith", text: $lastName)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color.offWhite.opacity(0.2))
                .cornerRadius(10)
        }
        .foregroundColor(.offWhite)
    }
    
    var progressView: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                ZStack {
                    
                    Circle()
                        .fill(Color.offWhite)
                    
                    Text("\(String(format: "%.0f", progress * 100))%")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.offBlack)
                    
                }
                .frame(width: 50, height: 50)
                .offset(x: (geo.size.width * progress) - 25)
                .animation(Animation.easeInOut(duration: 1.0))
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geo.size.width)
                        .foregroundColor(Color.offWhite.opacity(0.2))
                        
                    Rectangle()
                        .fill(
                            LinearGradient(gradient:
                                            Gradient(
                                                colors: [colorStart, colorEnd]),
                                                startPoint: .leading,
                                                endPoint: .trailing)
                                
                        )
                        .frame(width: min(progress * geo.size.width, geo.size.width))
                        .animation(Animation.easeInOut(duration: 1.0))
                }
                .cornerRadius(45)
            }
        }
        .padding(.horizontal)
        .frame(height: 80)
    }
}

struct OnboardingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingProgressView()
    }
}
