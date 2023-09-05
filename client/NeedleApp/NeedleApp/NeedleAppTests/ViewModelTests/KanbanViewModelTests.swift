//
//  KanbanViewModelTests.swift
//  NeedleAppTests
//
//  Created by matheusvb on 05/09/23.
//

import XCTest
import SwiftUI
@testable import NeedleApp

final class KanbanViewModelTests: XCTestCase {
    var dbMock: DBMock!
    var taskDS: TaskDataServiceMock!
    
    @State var selectedColumn = TaskStatus.IN_PROGRESS
    @State var showPopUp = false
    @State var showCard = false
    @State var selectedTask: TaskModel? = nil
    @State var isEditing = false
    
    var sut: KanbanViewModel<TaskDataServiceMock>!
    
    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.taskDS = TaskDataServiceMock(db: dbMock)
        
        self.sut = KanbanViewModel(
            localTasks: [],
            role: .DEVELOPER,
            selectedColumn: $selectedColumn,
            showPopUp: $showPopUp,
            showCard: $showCard,
            selectedWorkspace: Workspace(id: "1", accessCode: "12345", name: "Workspace", users: []),
            selectedTask: $selectedTask,
            isEditing: $isEditing,
            taskDS: self.taskDS
        )
    }

    override func tearDownWithError() throws {
        self.dbMock = nil
        self.taskDS = nil
        self.sut = nil
    }

    func test_updateTaskStatus() throws {
        dbMock.tasksInWorkspace["1"] = [TaskModel(id: "1", title: "First task", description: "Description", status: .TODO, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "1", taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z")]
        
        sut.updateTaskStatus(taskId: "1", status: .IN_PROGRESS)
        
        XCTAssertEqual(dbMock.tasksInWorkspace["1"]!.first!.status, .IN_PROGRESS)
    }
    
    func test_addItem() throws {
        dbMock.tasksInWorkspace["1"] = [TaskModel(id: "1", title: "First task", description: "Description", status: .TODO, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "1", taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z")]
        
        sut.localTasks = dbMock.tasksInWorkspace["1"]!
        sut.addItem(currentlyDragging: "1", status: .IN_PROGRESS)
        
        XCTAssertEqual(sut.localTasks.first!.status, .IN_PROGRESS)
        XCTAssertEqual(dbMock.tasksInWorkspace["1"]!.first!.status, .IN_PROGRESS)
    }

    func test_swapItem() throws {
        dbMock.tasksInWorkspace["1"] = [TaskModel(id: "1", title: "First task", description: "Description", status: .TODO, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "1", taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z")]
        
        dbMock.tasksInWorkspace["1"]?.append(TaskModel(id: "2", title: "Second task", description: "Description", status: .IN_PROGRESS, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "1", taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"))
        
        sut.localTasks = dbMock.tasksInWorkspace["1"]!
        
        sut.swapItem(droppingTask: TaskModel(id: "1", title: "First task", description: "Description", status: .TODO, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "1", taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"), currentlyDragging: "2")
        
        XCTAssertEqual(dbMock.tasksInWorkspace["1"]!.first(where: { $0.id == "2"})?.status, .TODO)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
