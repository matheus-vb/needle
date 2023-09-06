//
//  EditTaskViewModelTests.swift
//  NeedleAppTests
//
//  Created by matheusvb on 04/09/23.
//

import XCTest
@testable import NeedleApp
import SwiftUI

final class EditTaskViewModelTests: XCTestCase {
    var dbMock: DBMock!
    var taskDS: TaskDataServiceMock!
    
    var stubWorkspace: Workspace!
    var stubTask: TaskModel!
    @State var isEditing = true
    
    var sut: EditTaskViewModel<TaskDataServiceMock>!

    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.taskDS = TaskDataServiceMock(db: dbMock)
        self.stubWorkspace = Workspace(id: "1", accessCode: "12345", name: "Workspace", users: [])
        self.stubTask = TaskModel(id: "1", title: "First task", description: "Description", status: .TODO, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: stubWorkspace.id, taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z")
        
        
        self.dbMock.tasksInWorkspace["1"] = [self.stubTask]
        self.sut = EditTaskViewModel(data: stubTask, workspaceID: stubWorkspace.id, members: [], isEditing: $isEditing, taskDS: taskDS)
    }

    override func tearDownWithError() throws {
        self.dbMock = nil
        self.taskDS = nil
        self.stubWorkspace = nil
        self.stubTask = nil
        
        self.sut = nil
    }

    func test_editTask() throws {
        dbMock.users = [User(id: "user1", name: "Username", email: "email", workspaces: [])]

        sut.prioritySelection = .HIGH
        sut.taskTitle = "New title"
        sut.taskDescription = "New description"
        sut.selectedMember = User(id: "user1", name: "Username", email: "email", workspaces: [])
        sut.deadLineSelection = Date()
        
        sut.saveTask()
        
        XCTAssertEqual(self.dbMock.tasksInWorkspace["1"]!.first!.title , "New title")
        XCTAssertEqual(self.dbMock.tasksInWorkspace["1"]!.first!.taskPriority , .HIGH)
        XCTAssertNotNil(self.dbMock.tasksInWorkspace["1"]!.first!.user)
        XCTAssertNotEqual(self.dbMock.tasksInWorkspace["1"]!.first!.endDate, "2023-07-13T00:00:00.000Z")
    }
    
    func test_archiveTask() throws {
        sut.archiveTask()
        
        XCTAssertEqual(self.dbMock.tasksInWorkspace["1"]!.first!.status, .NOT_VISIBLE)
    }
    
    func test_unarchiveTask() throws {
        dbMock.tasksInWorkspace["1"]!.append(TaskModel(id: "1", title: "First task", description: "Description", status: .NOT_VISIBLE, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: stubWorkspace.id, taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"))
        
        sut.unarchiveTask()
        
        XCTAssertNotEqual(self.dbMock.tasksInWorkspace["1"]!.first!.status, .NOT_VISIBLE)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
