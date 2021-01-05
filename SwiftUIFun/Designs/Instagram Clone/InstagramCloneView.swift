//
//  InstagramCloneView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 30/12/2020.
//

import SwiftUI

struct InstagramCloneView: View {
    
    var body: some View {
        
        ZStack {
            // Background Color
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // Navigation Bar
                InstagramCloneNavigationBar()
                
                // Main Content
                InstagramCloneContentSection()
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        
    }
}

struct InstagramCloneNavigationBar: View {
    var body: some View {
        HStack {
            IconButton(image: Image(systemName: "plus.app"))
            
            Spacer()
            
            Image("instagram-text-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                
            
            Spacer()
            
            IconButton(image: Image(systemName: "paperplane"))
        }
        .padding()
        
    }
}

struct InstagramCloneContentSection: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            // Stories View
            InstagramCloneStoriesView()
            
            // Feed
            InstagramCloneFeedView()
        }
    }
}

struct InstagramCloneStoriesView: View {
    
    let storyProfileImageNames = ["profile-photo-1", "profile-photo-2", "profile-photo-3", "profile-photo-4", "profile-photo-5", "profile-photo-6", "profile-photo-7", "profile-photo-8", "profile-photo-9"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                
                VStack {
                    CurrentUsersProfileButton(imageName: "Profile-icon")
                        .frame(width: 75, height: 75)
                    
                    Text("Your story")
                        .font(.caption)
                }
                
                ForEach(storyProfileImageNames, id: \.self) { imageName in
                    VStack {
                        ProfileButton(imageName: imageName, isWatched: false, size: 75)
                            .frame(width: 75, height: 75)
                        
                        Text("smith.john")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
            
        }
    }
}

struct InstagramCloneFeedView: View {
    let feedImageNames = ["unsplash-1", "unsplash-2", "unsplash-3", "unsplash-4", "unsplash-5", "unsplash-6", "unsplash-7", "unsplash-8", "unsplash-9", "unsplash-10", "unsplash-11"]
    
    var body: some View {
        ForEach(feedImageNames, id: \.self) { imageName in
            FeedItemView(iconName: "profile-photo-\(Int.random(in: 1..<9))", imageName: imageName)
        }
    }
}

struct IconButton: View {
    let image: Image
    
    var body: some View {
        Button(action: {}, label: {
            image
                .resizable()
                .scaledToFit()
                .padding(5)
                .frame(width: 30, height: 30)
                .accentColor(.offBlack)
            
        })
    }
}

struct NeumorphicIconButton: View {
    let image: Image
    
    var body: some View {
        Button(action: {}, label: {
            image
                .resizable()
                .scaledToFit()
                .padding(5)
                .frame(width: 25, height: 25)
                .accentColor(.offBlack)
            
        })
        .buttonStyle(NeumorphicButtonStyle())
    }
}

struct FeedItemView: View {
    let iconName: String
    let imageName: String
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            HStack {
                ProfileButton(imageName: iconName, isWatched: false, size: 35)
                    .frame(width: 35, height: 35)
                
                Text("john.smith")
                    .font(.subheadline)
                
                Spacer()
                
                NeumorphicIconButton(image: Image(systemName: "ellipsis"))
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
            
            GeometryReader { geo in
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: 350)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white, radius: 10, x: -10, y: -10)
                    .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.offWhite, lineWidth: 5))
                
                
            }
            .padding(.horizontal)
            .frame(height: 350)
            
            HStack {
                NeumorphicIconButton(image: Image(systemName: "heart"))
                NeumorphicIconButton(image: Image(systemName: "message"))
                NeumorphicIconButton(image: Image(systemName: "paperplane"))
                
                Spacer()
                
                NeumorphicIconButton(image: Image(systemName: "bookmark"))
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
            
        }
    }
}

struct ProfileButton: View {
    
    let imageName: String
    let isWatched: Bool
    let size: CGFloat
    
    var body: some View {
        Button(action: {}, label: {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .strokeBorder(Color.offWhite, lineWidth: 5)
                        
                )
                .if(!isWatched) {
                    $0.overlay(
                        Circle()
                            .strokeBorder(LinearGradient(Color.red, Color.yellow), lineWidth: 2.5)
                    )
                }
                .aspectRatio(contentMode: .fill)
                
        })
        .accentColor(.offBlack)
    }
}

struct CurrentUsersProfileButton: View {
    let imageName: String
    
    var body: some View {
        ZStack {
            ProfileButton(imageName: imageName, isWatched: true, size: 75)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "plus")
                        .padding(4)
                        .background(Circle().fill(Color.blue))
                        .foregroundColor(.white)
                        .overlay(Circle()
                                    .strokeBorder(Color.offWhite, lineWidth: 2))
                }
            }
            
        }
    }
}

struct InstagramCloneView_Previews: PreviewProvider {
    static var previews: some View {
        InstagramCloneView()
    }
}
