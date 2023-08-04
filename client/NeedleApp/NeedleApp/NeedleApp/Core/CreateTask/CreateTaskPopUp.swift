//
//  CreateTaskPopUp.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI

struct CreateTaskPopUp: View {
    @StateObject var createTaskViewModel: CreateTaskViewModel = CreateTaskViewModel()
    var geometry: GeometryProxy
    var body: some View {
        VStack{
            TitleEditableText(text: $createTaskViewModel.taskTitle)
        }
        .frame(width: geometry.size.width/3.0, height: geometry.size.height)
        .background(.white)
    }
}
