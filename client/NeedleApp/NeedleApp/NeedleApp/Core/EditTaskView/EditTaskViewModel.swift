//
//  EditTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation
import SwiftUI

class EditTaskViewModel<D: DocumentationDataServiceProtocol & ObservableObject, T: TaskDataServiceProtocol & ObservableObject>: ObservableObject{
    @AppStorage("userID") var userID: String = "Default User"
    
    private var documentationDS: D
    private var taskDS: T
    
    let selectedTask: TaskModel
    @Binding var isEditing: Bool
    @Published var documentationID: String
    @Published var workspaceID: String
    @Published var taskId: String
    @Published var taskDescription: String
    @Published var taskTitle: String
    @Published var statusSelection: TaskStatus
    @Published var prioritySelection: TaskPriority
    @Published var deadLineSelection: Date
    @Published var categorySelection: TaskType
    @Published var selectedMember: User?
    @Published var documentationString: NSAttributedString
    @Published var members: [User]
    @Published var isDeleting: Bool = false
    
    init(data: TaskModel, workspaceID: String, members: [User], isEditing: Binding<Bool>, documentationDS: D, taskDS: T) {
        self.selectedTask = data
        self._isEditing = isEditing
        let isoDateString = data.endDate
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        let date = formatter.date(from: isoDateString)
        self.workspaceID = workspaceID
        self.taskId = data.id
        self.taskDescription = data.description
        self.taskTitle = data.title
        self.statusSelection = data.status
        self.prioritySelection = data.taskPriority
        self.deadLineSelection = date!
        self.categorySelection = data.type
        self.selectedMember = data.user
        self.documentationString = NSAttributedString(string: data.document?.text ?? "")
        self.documentationID = data.document?.id ?? "0"
        self.members = members
        self.documentationDS = documentationDS
        self.taskDS = taskDS
        
        //Pegar a documentacao
        let decodedData = Data(base64Encoded: data.document?.text ?? "", options: .ignoreUnknownCharacters)
        do{
            let decoded = try NSAttributedString(data: decodedData!, format: .rtf)
            self.documentationString = decoded
        }catch{
            print(error)
        }
    }
    
    func saveTask(dataDTO: SaveTaskDTO){
        taskDS.saveTask(dto: dataDTO, userId: userID, workspaceId: self.workspaceID)
    }
    
    func updateDoc(dataDTO: UpdateDocumentationDTO){
        print("oooi")
        documentationDS.updateDocumentation(data: dataDTO, userId: userID, workspaceId: self.workspaceID)
    }
    
    func archiveTask(task: TaskModel){
        taskDS.updateTaskStatus(taskId: task.id, status: TaskStatus.NOT_VISIBLE, userId: userID, workspaceId: workspaceID)
    }
    
    func unarchiveTask(task: TaskModel){
        taskDS.updateTaskStatus(taskId: task.id, status: TaskStatus.TODO, userId: userID, workspaceId: workspaceID)
    }
}
