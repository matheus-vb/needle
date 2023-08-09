//
//  EditTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation
import SwiftUI

class EditTaskViewModel: ObservableObject{
    @AppStorage("userID") var userID: String = "Default User"
    @Published var documentationID: String
    @Published var workspaceID: String
    @Published var taskId: String
    @Published var taskDescription: String
    @Published var taskTitle: String
    @Published var statusSelection: TaskStatus
    @Published var prioritySelection: TaskPriority
    @Published var deadLineSelection: Date
    @Published var categorySelection: TaskType
    @Published var selectedMember: WorkspaceUser
    @Published var documentationString: NSAttributedString
    @Published var members: [User]
    
    init(data: TaskModel, workspaceID: String, members: [User]) {
        let isoDateString = data.endDate
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        let date = formatter.date(from: isoDateString)
        self.workspaceID = workspaceID
        self.taskId = data.id ?? "1"
        self.taskDescription = data.description
        self.taskTitle = data.title
        self.statusSelection = TaskStatus(rawValue: data.status)!
        self.prioritySelection = data.taskPriority
        self.deadLineSelection = date!
        self.categorySelection = TaskType(rawValue: data.type)!
        self.selectedMember = WorkspaceUser(id: "1", name: "Medeiros")
        self.documentationString = NSAttributedString(string: data.document?.text ?? "")
        self.documentationID = data.document?.id ?? "0"
        self.members = members
        //Pegar a documentacao
        let decodedData = Data(base64Encoded: data.document?.text ?? "", options: .ignoreUnknownCharacters)
        do{
            let decoded = try NSAttributedString(data: decodedData!, format: .rtf)
            self.documentationString = decoded
        }catch{
            print(error)
        }
    }
    
    func updateDoc(dataDTO: UpdateDocumentationDTO){
        DocumentationDataService.shared.updateDocumentation(data: dataDTO, userId: userID, workspaceId: self.workspaceID)
    }
}
