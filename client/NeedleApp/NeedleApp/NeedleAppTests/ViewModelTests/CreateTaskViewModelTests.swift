//
//  CreateTaskViewModelTests.swift
//  NeedleAppTests
//
//  Created by matheusvb on 30/08/23.
//

import XCTest
import SwiftUI
@testable import NeedleApp

final class CreateTaskViewModelTests: XCTestCase {
    var dbMock: DBMock!
    var taskDS: TaskDataServiceMock!
    var stubWorkspace: Workspace!
    var statusSelection: TaskStatus!
    
    var sut: CreateTaskViewModel<TaskDataServiceMock>!
    
    @State var showPopUp = false
    
    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.taskDS = TaskDataServiceMock(db: dbMock)
        self.stubWorkspace = Workspace(id: "1", accessCode: "12345", name: "Workspace", users: [])
        self.statusSelection = .TODO

        self.sut = CreateTaskViewModel(members: [], showPopUp: $showPopUp, selectedWorkspace: self.stubWorkspace, selectedStatus: self.statusSelection, taskDS: taskDS)
    }

    override func tearDownWithError() throws {
        self.dbMock = nil
        self.taskDS = nil
        self.stubWorkspace = nil
        self.sut = nil
    }

    func test_createTask() throws {
        dbMock.tasksInWorkspace[self.stubWorkspace.id] = []
        
        sut.userID = "userId"
        sut.taskDescription = "Description"
        sut.taskTitle = "Title"
        sut.statusSelection = self.statusSelection
        sut.prioritySelection = .MEDIUM
        sut.deadLineSelection = Date()
        sut.categorySelection = .DEV
        
        sut.createTask()
        sut.createTask()
        
        guard let actual = dbMock.tasksInWorkspace[self.stubWorkspace.id]?.count else { return }
        let expected = 2
        
        XCTAssertEqual(actual, expected)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
