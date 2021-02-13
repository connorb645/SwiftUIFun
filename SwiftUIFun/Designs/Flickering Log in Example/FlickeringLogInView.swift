//
//  FlickeringLogInScreen.swift
//  SwiftUIFun
//
//  Created by Connor Black on 13/01/2021.
//

import SwiftUI

struct FlickeringLogInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            LightlyFlickeringBackgroundView()
            VStack {
                
                FLITitle()
                
                VStack(spacing: 20) {
                    FLTTextField(title: "Email", iconTitle: "envelope", text: $email)
                    
                    FLTTextField(title: "Password", iconTitle: "lock", text: $password)
                    
                    FLTForgotPassword()
                    
                    VStack(spacing: 10) {
                        FLTLoginButton()
                        
                        FLTSignUpButton()
                    }
                    
                }
                .padding(.horizontal)
                                      
            }
            .padding(40)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        
    }
}

struct FLTForgotPassword: View {
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {}, label: {
                Text("Forgot Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.offBlack)
            })
        }
    }
}

struct FLTLoginButton: View {
    var body: some View {
        Button(action: {}, label: {
            Text("Let's Go!")
                .foregroundColor(.offWhite)
                .font(.headline)
                .fontWeight(.bold)
        })
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

struct FLTSignUpButton: View {
    var body: some View {
        Button(action: {}, label: {
            Text("Create an account")
                .foregroundColor(.blue)
                .fontWeight(.medium)
        })
        .frame(maxWidth: .infinity)
    }
}

struct FLITitle: View {
    
    var body: some View {
        Text("Welcome")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.offBlack)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

struct FLTTextField: View {
    
    let title: String
    let iconTitle: String
    @Binding var text: String
    
    let grey = Color.black.opacity(0.25)
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: iconTitle)
                    .foregroundColor(grey)
                
                TextField(title, text: $text)
                    .foregroundColor(grey)
                    .frame(height: 40)
                                            
            }
            
            grey
                .opacity(0.35)
                .frame(height: 2)
        }
        
    }
}

struct FlickeringLogInView_Previews: PreviewProvider {
    static var previews: some View {
        FlickeringLogInView()
    }
}
