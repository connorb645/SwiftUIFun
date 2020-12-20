//
//  UIDPHomeView.swift
//  SwiftUIFun
//
//  Created by Connor Black on 20/12/2020.
//

import SwiftUI

struct UIDPCourse {
    let id: Int
    let title: String
    let description: String
    let imageName: String
    let likeCount: Int
    let cost: Int
    let backgroundColor: Color
    let videoCount: Int
    let completionPercentage: CGFloat
    let gradientEndColor: Color
}

let uiUxDesign = UIDPCourse(id: 1, title: "UI/UX Design", description: "Visual Design is the use of imagery, color, shapes, typography, and form to enhance usability and improve the user experience. Visual design as a field has grown out of both UI deign and graphic design.", imageName: "Saly-22", likeCount: 2100, cost: 59, backgroundColor: .uidpBlueBackgroud, videoCount: 24, completionPercentage: 92, gradientEndColor: .uidpBlueGradient)
let webDesign = UIDPCourse(id: 2, title: "Web Design", description: "Visual Design is the use of imagery, color, shapes, typography, and form to enhance usability and improve the user experience. Visual design as a field has grown out of both UI deign and graphic design.", imageName: "Saly-11", likeCount: 1200, cost: 46, backgroundColor: .uidpPinkBackgroud, videoCount: 22, completionPercentage: 54, gradientEndColor: .uidpPinkGradient)
let swiftUi = UIDPCourse(id: 3, title: "SwiftUI", description: "Visual Design is the use of imagery, color, shapes, typography, and form to enhance usability and improve the user experience. Visual design as a field has grown out of both UI deign and graphic design.", imageName: "Saly-24", likeCount: 2900, cost: 59, backgroundColor: .uidpRedBackground, videoCount: 23, completionPercentage: 77, gradientEndColor: .uidpRedGradient)
let visualDesign = UIDPCourse(id: 4, title: "Visual Design", description: "Visual Design is the use of imagery, color, shapes, typography, and form to enhance usability and improve the user experience. Visual design as a field has grown out of both UI deign and graphic design.", imageName: "Saly-19", likeCount: 2700, cost: 46, backgroundColor: .uidpPurpleBackgroud, videoCount: 27, completionPercentage: 88, gradientEndColor: .uidpPurpleGradient)

var allCourses: [UIDPCourse] {
    [uiUxDesign, webDesign, swiftUi, visualDesign]
}

struct UIDPHomeView: View {
    
    @State var selectedCourse: UIDPCourse?
    
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            if selectedCourse != nil {
                UIDPCourseDetailView(selectedCourse: $selectedCourse, namespace: namespace)
            } else {
                UIDPCoursesOverviewView(selectedCourse: $selectedCourse, namespace: namespace)
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct UIDPCourseDetailView: View {
    @Binding var selectedCourse: UIDPCourse?
    
    var namespace: Namespace.ID
    
    @State var animateBackgroundColourView: Bool = false
    
    @State var titleOpacity: Double = 0.0
    @State var descriptionOpacity: Double = 0.0
    @State var buttonOpacity: Double = 0.0
    
    var body: some View {
                
        ZStack(alignment: .top) {
            UIDPCourseDetailNavigationBarView(selectedCourse: $selectedCourse, backgroundAnimated: $animateBackgroundColourView)
                .zIndex(2)
            
            if let course = selectedCourse {
                                
                ScrollView {
                    ZStack(alignment: .top) {
                        VStack {
                            EmptyView()
                        }
                        .frame(height: animateBackgroundColourView ? 500 : 0)
                        .frame(maxWidth: .infinity)
                        .background(course.backgroundColor
                                        .cornerRadius(30))
                        
                        VStack {
                            
                            EmptyView()
                                .frame(height: 500)
                            
                            Image(course.imageName)
                                .resizable()
                                .matchedGeometryEffect(id: course.id, in: namespace)
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .frame(height: 400)
                                .padding(.top, 100)
                            
                            VStack(alignment: .leading) {
                                Text(course.title)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.offBlack)
                                    .opacity(titleOpacity)
                                Text(course.description)
                                    .font(.body)
                                    .foregroundColor(.offBlack)
                                    .padding(.top)
                                    .opacity(descriptionOpacity)
                            }
                            .padding(.vertical, 20)
                            
                            Button(action: {print("Do nothing")}, label: {
                                Text("Buy Course £\(course.cost)")
                                    .font(.title)
                                    .fontWeight(.semibold)
                            })
                            .accentColor(.offWhite)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(RoundedRectangle(cornerRadius: 100).fill(Color.offBlack))
                            .opacity(buttonOpacity)
                            
                        }
                        .padding(.horizontal, 20)
                        .zIndex(1)
                        
                    }.onAppear {
                        withAnimation(Animation.easeInOut(duration: 1).delay(1)) {
                            titleOpacity = 1.0
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 1).delay(1.1)) {
                            descriptionOpacity = 1.0
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 1).delay(1.2)) {
                            buttonOpacity = 1.0
                        }
                        
                    }
                    
                }
                
            }
            
        }.edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(Animation.spring().delay(0.5)) {
                animateBackgroundColourView.toggle()
            }
        }
        
    }
}

struct UIDPCoursesOverviewView: View {
    @Binding var selectedCourse: UIDPCourse?
    
    @State var fadeInCurrent = false
    
    var namespace: Namespace.ID
    
    var body: some View {
            
        VStack {
            
            UIDPCoursesOverviewNavigationBarView()
            
            ScrollView {
                
                UIDPCurrentCoursesView(currentCourses: [swiftUi, visualDesign, uiUxDesign])
                    .opacity(fadeInCurrent ? 1.0 : 0.0)
                
                UIDPCoursesView(courses: allCourses, namespace: namespace, selectedCourse: $selectedCourse)
                    .zIndex(1)
                
                
            }.background(Color.white)

        }.onAppear {
            withAnimation(Animation.easeInOut(duration: 1).delay(0.5)) {
                self.fadeInCurrent = true
            }
        }
    }
}

struct UIDPCoursesView: View {
    
    var courses: [UIDPCourse]
    var namespace: Namespace.ID
    @Binding var selectedCourse: UIDPCourse?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(),spacing: 15), GridItem(.flexible(),spacing: 15)], spacing: 15) {
            
            ForEach(courses, id: \.id) { course in
                Button(action: {
                    withAnimation(Animation.spring()) {
                        selectedCourse = course
                    }
                }, label: {
                    UIDPCourseView(course: course, namespace: namespace)
                })
                .accentColor(.offBlack)
            }
            
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 20)
    }
}

struct UIDPCourseView: View {
    
    let course: UIDPCourse
    let offset: CGFloat = 180
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Image(course.imageName)
                .resizable()
                .matchedGeometryEffect(id: course.id, in: namespace)
                .scaledToFit()
                .frame(height: 150)
                .zIndex(1)
                .padding(.bottom, offset)
                
            
            VStack {
                
                VStack {
                    
                    VStack(alignment: .leading) {
                        Text(course.title)
                            .font(.headline)
                            .fontWeight(.bold)
                        Text("\(course.videoCount) Videos")
                            .font(.caption)
                            .fontWeight(.light)
                    }
                    
                    PercentageView(progress: course.completionPercentage, lineWidth: 10, startColor: course.backgroundColor, endColor: course.gradientEndColor, fontScale: .large)
                        .frame(width: 100, height: 100)
                                        
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    
                    RoundedRectangle(cornerRadius: 20).fill(
                        LinearGradient(gradient: Gradient(colors: [.offWhite, course.backgroundColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    ).opacity(1)
                )
                
            }
            .frame(maxWidth: .infinity)
            .padding(.top, offset * 0.55)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(course.backgroundColor)
                    .shadow(radius: 10)
            )
        
            
        }
        
    }
}

struct UIDPCurrentCoursesView: View {
    
    var currentCourses: [UIDPCourse]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible(minimum: 10))], spacing: 15) {
                ForEach(currentCourses, id: \.id) { course in
                    Button(action: {}, label: {
                        UIDPCurrentCourseView(course: course)
                    })
                    .accentColor(.offBlack)
                }
            }
            .padding(.horizontal, 15)
        }.frame(height: 100)
    }
}

struct UIDPCurrentCourseView: View {
    
    var course: UIDPCourse
    
    var body: some View {
        HStack {
                // Percentage View
                PercentageView(progress: course.completionPercentage, lineWidth: 3, startColor: course.backgroundColor, endColor: course.gradientEndColor, fontScale: .small)
                    .frame(width: 50, height: 50)
                
                // title and video count
                VStack(alignment: .leading) {
                    Text(course.title)
                        .foregroundColor(.offBlack)
                        .font(.headline)
                    Text("\(course.videoCount) Videos")
                        .foregroundColor(.offBlack)
                        .font(.caption)
                        .fontWeight(.light)
                }

            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color.white)
        .cornerRadius(100)
        .shadow(radius: 8)
        
    }
}

struct UIDPCoursesOverviewNavigationBarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        HStack {
            
            Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                Image(systemName: "arrow.backward")
                    
            })
            .frame(width: 40, height: 40)
            .padding(.leading, 8)
            .accentColor(.offBlack)
            
            Spacer()
                        
            logo
                
            Spacer()
            
            Button(action: { print("go back") }, label: {
                Image("Profile-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    
            })
            .frame(width: 40, height: 40)
            .padding(.trailing, 8)
            .accentColor(.offBlack)
        }
        .padding(.top,  10)
        .padding(.bottom, 10)
    }
    
    var logo: some View {
        Text("uides")
            .foregroundColor(.offBlack)
            .font(.headline)
            .fontWeight(.bold)
        + Text("i")
            .foregroundColor(.red)
            .font(.headline)
            .fontWeight(.bold)
        + Text("gn.")
            .foregroundColor(.offBlack)
            .font(.headline)
            .fontWeight(.bold)
        + Text("pro")
            .foregroundColor(.red)
            .font(.headline)
            .fontWeight(.bold)
        
    }
}

struct UIDPCourseDetailNavigationBarView: View {
    
    @Binding var selectedCourse: UIDPCourse?
    @Binding var backgroundAnimated: Bool
        
    var body: some View {
        
        if let course = selectedCourse {
            HStack {
                
                Button(action: {
                    withAnimation(Animation.spring()) {
                        backgroundAnimated = false
                    }
                    withAnimation(Animation.spring().delay(0.3)) {
                        selectedCourse = nil
                    }
                }, label: {
                    Image(systemName: "arrow.backward")
                        
                })
                .frame(width: 40, height: 40)
                .padding(.leading, 8)
                .accentColor(.offBlack)
                
                Spacer()
                                        
                Button(action: { print("do nothing") }, label: {
                    Image(systemName: "circle.grid.2x2.fill")
                })
                .frame(width: 40, height: 40)
                .padding(.trailing, 8)
                .accentColor(.offBlack)
            }
            
            .padding(.top,  50)
            .padding(.bottom, 25)
//            .background(course.backgroundColor)
            .cornerRadius(30)
        }
        
    }
}

struct UIDPHomeView_Previews: PreviewProvider {
    static var previews: some View {
        UIDPHomeView()
    }
}
