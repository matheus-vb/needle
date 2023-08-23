//
//  EditTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation
import SwiftUI
import Combine

class EditTaskViewModel<D: DocumentationDataServiceProtocol & ObservableObject, T: TaskDataServiceProtocol & ObservableObject>: ObservableObject{
    @AppStorage("userID") var userID: String = "Default User"
    private var cancellables = Set<AnyCancellable>()
    
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
    var dto: SaveTaskDTO
    
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
        
        self.dto = SaveTaskDTO(
            userId: nil,
            taskId: data.id,
            documentId: data.documentId ?? "",
            title: data.title,
            description: data.description,
            status: data.status.rawValue,
            type: data.type.rawValue,
            endDate: data.endDate,
            priority: data.taskPriority.rawValue,
            text: data.document?.text ?? "",
            textString: data.document?.textString ?? ""
        )
        
        self.setupBindings()
    }
    
    func setupBindings() {
        Publishers.CombineLatest4($selectedMember, $taskTitle, $taskDescription, $statusSelection)
            .sink(receiveValue: { [weak self] (selectedMember, taskTitle, taskDescription, statusSelection) in
                self?.dto.userId = selectedMember?.id
                self?.dto.title = taskTitle
                self?.dto.description = taskDescription
                self?.dto.status = statusSelection.rawValue
            })
            .store(in: &cancellables)
        
        Publishers.CombineLatest4($categorySelection, $deadLineSelection, $prioritySelection, $documentationString)
            .sink(receiveValue: { [weak self] (categorySelection, deadLineSelection, prioritySelection, documentationString) in
                self?.dto.type = categorySelection.rawValue
                self?.dto.endDate = "\(deadLineSelection)"
                self?.dto.priority = prioritySelection.rawValue
                self?.dto.textString = documentationString.string
                print(documentationString.string)
                print(self?.dto.textString)
                do {
                    let data = try documentationString.richTextData(for: .rtf)
                    let encodedData = data.base64EncodedString(options: .lineLength64Characters)
                    self?.dto.text = encodedData
                } catch {
                    print("ERRO NO ENCODE")
                }
            })
            .store(in: &cancellables)
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
