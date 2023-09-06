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
    func dumb() {}

    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.workspaceDS = WorkspaceDataServiceMock(db: dbMock)
        self.taskDS = TaskDataServiceMock(db: dbMock)
        self.authDS = AuthenticationManagerMock(db: dbMock)
        self.sut = ProjectViewModel(selectedWorkspace: stubWorksapce, manager: authDS, taskDS: taskDS, workspaceDS: workspaceDS)
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
        
        XCTAssertEqual(expectedValue, expectedValue)
    }
    
    func test_deleteTask() throws {
        
    }

    func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
    }
}
