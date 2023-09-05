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

final class WorkspaceCardViewModelTests: XCTestCase {
    var dbMock: DBMock!
    var workspaceDS: WorkspaceDataServiceMock!
    var taskDS: TaskDataServiceMock!
    var authDS: AuthenticationManagerMock!
    var sut: WorkspaceCardViewModel<AuthenticationManagerMock, TaskDataServiceMock,WorkspaceDataServiceMock>!
    var stubWorksapce = Workspace(id: "1", accessCode: "123", name: "Meu Workspace", users: [PmMember(id: "1", userRole: "PRODUCT_MANAGER", userId: "1", workspaceId: "1", user: UserInfo(name: "Medeiros"))])
    func dumb() {}

    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.workspaceDS = WorkspaceDataServiceMock(db: dbMock)
        self.taskDS = TaskDataServiceMock(db: dbMock)
        self.authDS = AuthenticationManagerMock(db: dbMock)
        self.sut = WorkspaceCardViewModel(manager: authDS, taskDS: taskDS, workspaceDS: workspaceDS, action: dumb, workspace: stubWorksapce)
    }

    override func tearDownWithError() throws {
        dbMock = nil
        workspaceDS = nil
        taskDS = nil
        authDS = nil
        sut = nil
    }

    func test_selectWorkspace() throws {
        let userID = "1"
        self.sut.authManager.user = User(id: "1", name: "Medeiros", email: "medeiros@email.com", workspaces: [UserWorkspace(userRole: Role.DEVELOPER)])
        dbMock.workspaces[userID] = [stubWorksapce]
        dbMock.tasksInWorkspace[stubWorksapce.id] = [TaskModel(id: "1", title: "Task", description: "Descricao", status: TaskStatus.TODO, type: TaskType.DESIGN, documentId: "1", endDate: "1", workId: stubWorksapce.id, taskPriority: TaskPriority.HIGH, document: nil, user: nil, created_at: "", updated_at: "")]
        dbMock.usersInWorkspace[stubWorksapce.id] = [User(id: "1", name: "Medeiros", email: "medeiros@email.com", workspaces: [UserWorkspace(userRole: Role.DEVELOPER)]), User(id: "2", name: "Bia", email: "bia@email.com", workspaces: [UserWorkspace(userRole: Role.PRODUCT_MANAGER)])]
        dbMock.roles[userID] = Role.DEVELOPER
            
        self.sut.selectWorkspace(workspaceId: stubWorksapce.id)
        
        guard let userRole = self.sut.authManager.roles[stubWorksapce.id] else {return}
        let expectedRole = Role.DEVELOPER
        
        guard let workspaceTasksCounter = self.sut.taskDS.allUsersTasks[userID]?.count else {return}
        let expectedWorkspaceTasksCounter = 1
        
        guard let workspaceMembersCounter = self.sut.workspaceDS.members[stubWorksapce.id]?.count else {return}
        let expectedWorkspaceMembersCounter = 2
        
       
        XCTAssertEqual(userRole, expectedRole)
        XCTAssertEqual(workspaceTasksCounter, expectedWorkspaceTasksCounter)
        XCTAssertEqual(workspaceMembersCounter, expectedWorkspaceMembersCounter)
    }

    func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
    }
}
