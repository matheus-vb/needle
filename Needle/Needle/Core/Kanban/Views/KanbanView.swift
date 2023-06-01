//
//  KanbanView.swift
//  Needle
//
//  Created by gabrielfelipo on 26/05/23.
//

import SwiftUI

struct KanbanView: View {
    @State public var finalScale: CGFloat = 1
    @State public var scale = 1.0
    public let minScale = 0.7
    public let maxScale = 1.5
    @State var geometryHeight: Double = 0.0
    
    struct InitialButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(.black)
                .background(Color(red: 0.82, green: 0.82, blue: 0.82))
                .cornerRadius(10)
        }
    }
    
    let workspace: Workspace
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged{ state in
                adjustScale(from: state)
            }
            .onEnded{ state in
                withAnimation{
                    validateScaleLimits()
                }
                finalScale = 1.0
            }
    }
    
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                KanbanSideBarView()
                
                Rectangle().frame(width: 2)
                    .background(.gray)
                
                
                ScrollView([.horizontal, .vertical]) {
                    
                    
                    ZStack(alignment: .center) {
                        
                        VStack{
                            Spacer().frame(height: pow(32 * (geometryHeight/957),scale))
                            KanbanComponentView(workspaceName: workspace.name)
                            
                            
                            
                        }.background(
                            GeometryReader { geometry in
                                Color.white
                                    .onAppear(){
                                        geometryHeight = geometry.size.height
                                    }
                            })
                        .scaleEffect(scale)
                        .gesture(magnification)
                        .frame(width: 1180 * scale, alignment: .top )
                        
                        VStack(alignment: .leading){
                        }.frame(height: geometryHeight * scale, alignment: .top)
                    }.padding(.horizontal,70)
                }.background(.white)
            }
            
            VStack{
                Spacer().frame(height: 24)
                HStack{
                    Spacer()
                    
                    Button(action: {
                        print("saí")
                    }) {
                        HStack{
                            Text("logout")
                                .font(.custom(.spaceGroteskBold, size: 13))
                            
                            Image(systemName: "xmark.icloud")
                                .frame(width: 22.46, height: 15.63)
                        }.frame(maxWidth: 114, maxHeight: 53)
                    }.buttonStyle(InitialButtonStyle())
                    
                    Spacer().frame(width: 24)
                }
                Spacer()
            }
        }
    }
    
    func adjustScale(from state: MagnificationGesture.Value) {
        let delta = state / finalScale
        scale *= delta
        finalScale = state
    }
    
    func getMinimumScaleAllowed() -> CGFloat {
        return max(scale, minScale)
    }
    
    func getMaximumScaleAllowed() -> CGFloat {
        return min(scale, maxScale)
    }
    
    func validateScaleLimits() {
        scale = getMinimumScaleAllowed()
        scale = getMaximumScaleAllowed()
    }
    
}
