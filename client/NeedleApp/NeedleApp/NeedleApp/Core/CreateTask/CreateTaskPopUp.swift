//
//  CreateTaskPopUp.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI

struct CreateTaskPopUp: View {
    @StateObject var createTaskViewModel: CreateTaskViewModel = CreateTaskViewModel()
    var body: some View {
        TitleEditableText(text: $createTaskViewModel.taskTitle)
    }
}
