//
//  RootViewModelTests.swift
//  NeedleAppTests
//
//  Created by matheusvb on 30/08/23.
//

import XCTest
@testable import NeedleApp

final class RootViewModelTests: XCTestCase {
    var dbMock: DBMock!
    var authManagerMock: AuthenticationManagerMock!
    var notifiactionDSMock: NotificationDataServiceMock!
    var taskDSMock: TaskDataServiceMock!
    var workspaceDS: WorkspaceDataServiceMock!
    
    var sut: RootViewModel<AuthenticationManagerMock, NotificationDataServiceMock, TaskDataServiceMock, WorkspaceDataServiceMock>!
        
    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.authManagerMock = AuthenticationManagerMock(db: dbMock)
        self.notifiactionDSMock = NotificationDataServiceMock(db: dbMock)
        self.taskDSMock = TaskDataServiceMock(db: dbMock)
        self.workspaceDS = WorkspaceDataServiceMock(db: dbMock)
        self.sut =  RootViewModel(manager: authManagerMock, notificationDS: notifiactionDSMock, taskDS: taskDSMock, workspaceDS: workspaceDS)
    }

    override func tearDownWithError() throws {
        self.dbMock = nil
        self.authManagerMock = nil
        self.notifiactionDSMock = nil
        self.sut = nil
    }

    func test_presentNotifications() throws {
        self.dbMock.notifications["userId01"] = [
            NotificationModel(id: "1", payload: "Something happened", userId: "userId01", workspaceId: "workspace1", workspace: NotificationWorkspace(id: "1", accessCode: "12345", name: "Workspace"), created_at: "-"),
            NotificationModel(id: "2", payload: "Something happened", userId: "userId01", workspaceId: "workspace1", workspace: NotificationWorkspace(id: "2", accessCode: "12345", name: "Workspace"), created_at: "-")
        ]
        
        self.authManagerMock.user = User(id: "userId01", name: "Name", email: "email@email.com", workspaces: [])
        
        sut.presentNotifications()
        
        let expected = 2
        let actual = sut.notifications.count
        
        XCTAssertEqual(actual, expected)
        XCTAssertTrue(sut.notificationIsPresented)
    }
    
    func test_logout() throws {
        self.authManagerMock.user = User(id: "userId01", name: "Name", email: "email@email.com", workspaces: [])
        
        sut.logout()
        
        XCTAssertNil(authManagerMock.user)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
