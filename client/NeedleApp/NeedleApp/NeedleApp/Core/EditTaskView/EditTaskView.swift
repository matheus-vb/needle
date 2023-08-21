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
        .popover(isPresented: $editTaskViewModel.isDeleting, content: {
            SheetView(type: .deleteTask)
                .environmentObject(projectViewModel)
                .environmentObject(editTaskViewModel)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
        })
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom],32)
        .frame(width: 2*geometry.size.width/3, height: 19*geometry.size.height/20)
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
