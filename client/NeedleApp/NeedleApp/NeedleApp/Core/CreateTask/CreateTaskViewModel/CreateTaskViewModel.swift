//
//  CreateTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation
import SwiftUI

class CreateTaskViewModel: ObservableObject{
    @Published var taskDescription: String = ""
    @Published var taskDescriptionPlaceHolder: String = NSLocalizedString( "Adicione uma breve descrição da tarefa", comment: "")
    @Published var taskTitle: String = NSLocalizedString( "Nome da Task", comment: "")
    
    @Published var statusSelection: TaskStatus = .TODO
    @Published var prioritySelection: TaskPriority = .LOW
    @Published var deadLineSelection = Date.now
    @Published var categorySelection: TaskType = .GENERAL
    @Published var selectedMemberId: String = ""
    @Published var documentationString: NSAttributedString = NSAttributedString(string: "")
    
    @Binding var showPopUp: Bool
    
    let seletectedWorkspace: Workspace
    let selectedStatus: TaskStatus
    
    @Published var members: [User]
    
    init(members: [User], showPopUp: Binding<Bool>, selectedWorkspace: Workspace, selectedStatus: TaskStatus) {
        self.members = members
        self._showPopUp = showPopUp
        self.seletectedWorkspace = selectedWorkspace
        self.selectedStatus = selectedStatus
    }
}
