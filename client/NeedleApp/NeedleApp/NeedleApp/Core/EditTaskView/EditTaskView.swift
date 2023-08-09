//
//  EditTaskView.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import SwiftUI

struct EditTaskPopUP: View {
    @EnvironmentObject var editTaskViewModel: EditTaskViewModel
    @EnvironmentObject var projectViewModel: ProjectViewModel
    var geometry: GeometryProxy
    var body: some View {
        VStack(spacing: 24){
            topSection
            contentStack
        }
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom],32)
        .frame(width: 2*geometry.size.width/3, height: geometry.size.height)
        .background(.white)
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            EditTaskPopUP(geometry: geometry)
        }
       
    }
}
