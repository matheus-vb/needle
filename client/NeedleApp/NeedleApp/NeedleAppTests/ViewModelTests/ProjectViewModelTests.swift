//
//  WorkspaceCardViewModelTests.swift
//  NeedleAppTests
//
//  Created by jpcm2 on 05/09/23.
//

import Foundation
import XCTest
import SwiftUI
@testable import NeedleApp

final class ProjectViewModelTests: XCTestCase {
    var dbMock: DBMock!
    var workspaceDS: WorkspaceDataServiceMock!
    var taskDS: TaskDataServiceMock!
    var authDS: AuthenticationManagerMock!
    var sut: ProjectViewModel<AuthenticationManagerMock, TaskDataServiceMock,WorkspaceDataServiceMock>!
    var stubWorksapce = Workspace(id: "1", accessCode: "123", name: "Meu Workspace", users: [PmMember(id: "1", userRole: "PRODUCT_MANAGER", userId: "1", workspaceId: "1", user: UserInfo(name: "Medeiros"))])
    var userId = "123"
    var stubSelectedTask = TaskModel(id: "1", title: "Teste", description: "Descricao", status: .PENDING, type: .DEV, documentId: nil, endDate: "", workId: "1", taskPriority: .LOW, document: nil, user: nil, created_at: "", updated_at: "")
    func dumb() {}

    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.workspaceDS = WorkspaceDataServiceMock(db: dbMock)
        self.taskDS = TaskDataServiceMock(db: dbMock)
        self.authDS = AuthenticationManagerMock(db: dbMock)
        self.sut = ProjectViewModel(selectedWorkspace: stubWorksapce, manager: authDS, taskDS: taskDS, workspaceDS: workspaceDS)
        self.sut.userID = userId
        self.sut.selectedTask = stubSelectedTask
        self.dbMock.workspaces[userId] = [self.sut.selectedWorkspace]
        self.dbMock.usersInWorkspace[stubWorksapce.id] = [User(id: userId, name: "Medeiros", email: "medeiros@email.com", workspaces: [UserWorkspace(userRole: .PRODUCT_MANAGER)])]
        self.dbMock.tasksInWorkspace[stubWorksapce.id] = [stubSelectedTask]
        self.dbMock.roles[stubWorksapce.id] = .PRODUCT_MANAGER
    }

    override func tearDownWithError() throws {
        dbMock = nil
        workspaceDS = nil
        taskDS = nil
        authDS = nil
        sut = nil
    }

    func test_getCode() throws{
        let expectedValue = self.stubWorksapce.accessCode
        let value = self.sut.getCode()
        
        XCTAssertEqual(value, expectedValue)
    }
    
    func test_deleteTask() throws {
        self.sut.deleteTask()
        
        let tasksInWorkspaceCounter = self.dbMock.tasksInWorkspace[stubWorksapce.id]!.count
        let expectedValue = 0
        XCTAssertEqual(tasksInWorkspaceCounter, expectedValue)
    }
    
    func test_getRoleInWorkspace() throws {
        self.sut.getRoleInWorkspace(workspaceId: stubWorksapce.id)
        
        let roleInWorkspace = self.sut.authMGR.roles[stubWorksapce.id]
        let expectedValue = Role.PRODUCT_MANAGER
        
        XCTAssertEqual(roleInWorkspace, expectedValue)
    }
        
    func test_getWorkspaceTasks() throws {
        self.sut.getWorkspaceTasks(workspaceId: stubWorksapce.id)
        
        let numberOfTasks = self.sut.tasksDS.allUsersTasks[stubWorksapce.id]!.count
        let expectedValue = 1
        
        XCTAssertEqual(numberOfTasks, expectedValue)
    }
    
    func test_getWorkspaceMembers() throws{
        self.sut.getWorkspaceMembers(workspaceId: stubWorksapce.id)
        
        let numberOfMembers = self.sut.worskpaceDS.members[stubWorksapce.id]!.count
        let expectedValue = 1
        
        XCTAssertEqual(expectedValue, numberOfMembers)
    }
    
    func test_copyToClipBoard() throws {
        self.sut.copyToClipBoard()
        
        let pasteBoard = NSPasteboard.general.string(forType: .string)
        let expectedValue = self.sut.selectedWorkspace.accessCode
        
        XCTAssertEqual(pasteBoard, expectedValue)
    }
    
    func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
    }
}
