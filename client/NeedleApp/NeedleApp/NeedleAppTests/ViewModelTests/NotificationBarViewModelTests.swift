//
//  NotificationBarViewModelTests.swift
//  NeedleAppTests
//
//  Created by matheusvb on 06/09/23.
//

import XCTest
@testable import NeedleApp

final class NotificationBarViewModelTests: XCTestCase {
    var dbMock: DBMock!
    var authManagerMock: AuthenticationManagerMock!
    var notificationDSMock: NotificationDataServiceMock!
    
    var sut: NotificationBarViewModel<NotificationDataServiceMock, AuthenticationManagerMock>!
    
    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.authManagerMock = AuthenticationManagerMock(db: dbMock)
        self.notificationDSMock = NotificationDataServiceMock(db: dbMock)
        self.sut = NotificationBarViewModel(notificationDS: notificationDSMock, authManager: authManagerMock)
    }

    override func tearDownWithError() throws {
        self.dbMock = nil
        self.authManagerMock = nil
        self.notificationDSMock = nil
        self.sut = nil
    }

    func test_getUserNotification() throws {
        self.dbMock.notifications["user1"] = [
            NotificationModel(id: "1", payload: "Event", userId: "user1", workspaceId: "w1", workspace: NotificationWorkspace(id: "w1", accessCode: "code", name: "Work1"), created_at: ""),
            NotificationModel(id: "2", payload: "Event 2", userId: "user1", workspaceId: "w1", workspace: NotificationWorkspace(id: "w1", accessCode: "code", name: "Work1"), created_at: "")
        ]
        
        self.authManagerMock.user = User(id: "user1", name: "Username", email: "email@email.com", workspaces: [])
        
        self.sut.getUserNotifications()
        
        XCTAssertEqual(self.sut.notifications.count, 2)
    }
    
    func test_deleteUserNotification() throws {
        self.sut.notifications = [
            NotificationModel(id: "1", payload: "Event", userId: "user1", workspaceId: "w1", workspace: NotificationWorkspace(id: "w1", accessCode: "code", name: "Work1"), created_at: ""),
            NotificationModel(id: "2", payload: "Event 2", userId: "user1", workspaceId: "w1", workspace: NotificationWorkspace(id: "w1", accessCode: "code", name: "Work1"), created_at: "")
        ]
        
        self.authManagerMock.user = User(id: "user1", name: "Username", email: "email@email.com", workspaces: [])
        
        self.sut.deleteUserNotification()
        
        XCTAssertEqual(self.sut.notifications.count, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
