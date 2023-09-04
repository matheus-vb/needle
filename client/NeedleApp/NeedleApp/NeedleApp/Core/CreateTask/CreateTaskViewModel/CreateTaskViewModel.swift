//
//  CreateTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation
import SwiftUI
import Firebase

class CreateTaskViewModel<
    T: TaskDataServiceProtocol & ObservableObject
>: ObservableObject{
    @AppStorage("userID") var userID: String = "Default User"
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
    
    private var taskDS: T
    
    init(members: [User], showPopUp: Binding<Bool>, selectedWorkspace: Workspace, selectedStatus: TaskStatus, taskDS: T) {
        self.members = members
        self._showPopUp = showPopUp
        self.seletectedWorkspace = selectedWorkspace
        self.selectedStatus = selectedStatus
        self.taskDS = taskDS
    }
    
    func createTask() {
        var selectedId: String?
        
        if selectedMemberId == "" {
            selectedId = nil
        } else {
            selectedId = selectedMemberId
        }
        
        let dto = CreateTaskDTO(
            userId: selectedId,
            accessCode: seletectedWorkspace.accessCode,
            title: taskTitle,
            description: taskDescription,
            stats: selectedStatus.rawValue,
            type: categorySelection.rawValue,
            endDate: "\(deadLineSelection)",
            priority: prioritySelection.rawValue,
            docTemplate: template.devTemplate
        )
        
        taskDS.createTask(dto: dto, userId: userID, workspaceId: seletectedWorkspace.id)
        Analytics.logEvent(K.addedTask.rawValue, parameters: nil)
    }
}
