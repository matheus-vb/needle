//
//  SearchDocumentsViewModelTests.swift
//  NeedleAppTests
//
//  Created by matheusvb on 06/09/23.
//

import XCTest
import SwiftUI
@testable import NeedleApp

final class SearchDocumentsViewModelTests: XCTestCase {
    var dbMock: DBMock!
    var taskDSMock: TaskDataServiceMock!
    
    var sut: SearchDocumentsViewModel<TaskDataServiceMock>!
    
    @State var selectedTask: TaskModel?
    @State var isEditing: Bool = false
    
    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.taskDSMock = TaskDataServiceMock(db: dbMock)
        
        self.sut = SearchDocumentsViewModel(tasks: [], workspaceId: "workspace1", selectedTask: $selectedTask, isEditing: $isEditing, taskDS: taskDSMock)
    }

    override func tearDownWithError() throws {
        self.dbMock = nil
        self.taskDSMock = nil
        self.sut = nil
    }

    func test_bindings() throws {
        self.dbMock.tasksInWorkspace["workspace1"] = [
            TaskModel(id: "1", title: "First task", description: "Description", status: .TODO, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "workspace1", taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"),
            TaskModel(id: "2", title: "Second task", description: "Description", status: .TODO, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "workspace1", taskPriority: .LOW, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"),
            TaskModel(id: "3", title: "Third task", description: "Description", status: .IN_PROGRESS, type: .DESIGN, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "workspace1", taskPriority: .HIGH, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"),
            TaskModel(id: "4", title: "Fourth task", description: "Description", status: .IN_PROGRESS, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "workspace1", taskPriority: .VERY_HIGH, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"),
            TaskModel(id: "5", title: "Fifth task", description: "Description", status: .PENDING, type: .DEVOPS, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "workspace1", taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"),
            TaskModel(id: "6", title: "Sixth task", description: "Description", status: .PENDING, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "workspace1", taskPriority: .LOW, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"),
            TaskModel(id: "7", title: "Seventh task", description: "Description", status: .DONE, type: .BUSINESS, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "workspace1", taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z"),
            TaskModel(id: "8", title: "Eight task", description: "Description", status: .NOT_VISIBLE, type: .DEV, documentId: "doc1", endDate: "2023-07-13T00:00:00.000Z", workId: "workspace1", taskPriority: .MEDIUM, document: nil, user: nil, created_at: "2023-07-13T00:00:00.000Z", updated_at: "2023-07-13T00:00:00.000Z")
        ]
        
        self.sut.tasks = self.dbMock.tasksInWorkspace["workspace1"]!
        XCTAssertEqual(self.sut.tasks.count, 8)
        
        self.sut.query = "First"
        XCTAssertEqual(self.sut.tasks.count, 1)
        self.sut.query = nil
        
        self.sut.selectedPriority = .MEDIUM
        XCTAssertEqual(self.sut.tasks.count, 4)
        self.sut.selectedPriority = nil
        
        self.sut.selectedArea = .DEVOPS
        XCTAssertEqual(self.sut.tasks.count, 1)
        self.sut.selectedArea = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
