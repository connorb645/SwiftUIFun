//
//  InteractiveDismissal.swift
//  SwiftUIFun
//
//  Created by Connor Black on 14/07/2021.
//

import SwiftUI

struct InteractiveDismissal: View {
    @State private var emailAddress = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollViewBottomContent {
                VStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Login")
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Email Address")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black.opacity(0.3))
                                .lineLimit(1)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            TextField("e.g. hello@venyoo.app", text: $emailAddress)
                                .keyboardType(.emailAddress)
                                .padding()
                                .background(Color.black.opacity(0.1))
                                .cornerRadius(30)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Password")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black.opacity(0.3))
                                .lineLimit(1)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            SecureField("e.g. myGreatPassword12!", text: $password)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color.black.opacity(0.1))
                                .cornerRadius(30)
                                .disableAutocorrection(true)
                            
                            Button {
                                print("Forgot Password Tapped")
                            } label: {
                                Text("Forgot password?")
                                    .foregroundColor(Color.purple)
                                    .font(.caption)
                                    .fontWeight(.regular)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear() {
            UIScrollView.appearance().keyboardDismissMode = .interactive
        }
    }
}

struct InteractiveDismissal_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveDismissal()
    }
}
