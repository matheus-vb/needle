//
// WorkspaceHomeViewModelTests.swift
// NeedleAppTests
//
// Created by jpcm2 on 04/09/23.
//
import XCTest
import SwiftUI
@testable import NeedleApp
final class WorkspaceHomeViewModelTests: XCTestCase {
  var dbMock: DBMock!
  var workspaceDS: WorkspaceDataServiceMock!
  var sut: WorkspaceHomeViewModel<WorkspaceDataServiceMock>!
    
  override func setUpWithError() throws {
      self.dbMock = DBMock()
      self.workspaceDS = WorkspaceDataServiceMock(db: dbMock)
      self.sut = WorkspaceHomeViewModel(workspaceDS: workspaceDS)
  }
    
  override func tearDownWithError() throws {
      self.dbMock = nil
      self.workspaceDS = nil
      self.sut = nil
  }
    
    func test_getUserWorkspaces() throws {
        let userId = "1"
        dbMock.workspaces[userId] = [Workspace(id: "2", accessCode: "123", name: "WorkspaceName", users: [PmMember(id: "1", userRole: "PRODUCT_MANAGER", userId: "1", workspaceId: "2", user: UserInfo(name: "Medeiro"))])]
        
        sut.workspaceDS.getUsersWorkspaces(userId: "1")
        let userWorkspaces = sut.workspaces.count
        let expected = 1
        XCTAssertEqual(userWorkspaces, expected)
    }
    
    func test() throws {
        XCTAssertEqual(2, 2)
    }
    
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
}
