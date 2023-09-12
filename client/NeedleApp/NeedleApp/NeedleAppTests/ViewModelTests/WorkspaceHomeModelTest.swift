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
    
    func test_updateTab(){
        let loggedUser = User(id: "1", name: "Medeiros", email: "medeiros@email.com", workspaces: [UserWorkspace(userRole: Role.DEVELOPER), UserWorkspace(userRole: Role.PRODUCT_MANAGER)])
        let memberWorkspace = Workspace(id: "1", accessCode: "123", name: "Workspace que sou membro", users: [PmMember(id: "1", userRole: "PRODUCT_MANAGER", userId: "2", workspaceId: "1", user: UserInfo(name: "PM")), PmMember(id: "2", userRole: "DEVELOPER", userId: "1", workspaceId: "1", user: UserInfo(name: "Medeiros"))])
        let PMWorkspace = Workspace(id: "2", accessCode: "321", name: "Workspace que sou PM", users: [PmMember(id: "2", userRole: "PRODUCT_MANAGER", userId: "1", workspaceId: "1", user: UserInfo(name: "Medeiros"))])
        self.sut.workspaces = [PMWorkspace, memberWorkspace]
        self.sut.userID = loggedUser.id
        
        //Testar se selecionar myWorkspaces
        self.sut.selectedTab = .myWorkspaces
        self.sut.updateTab()
        for workspaces in self.sut.searchResults{
            XCTAssertEqual(workspaces.users[0].userId, loggedUser.id)
        }
        
        //Testar se selecionar "Projetos que participo"
        self.sut.selectedTab = .joinedWorkspaces
        self.sut.updateTab()
        for workspaces in self.sut.searchResults{
            XCTAssertNotEqual(workspaces.users[0].userId, loggedUser.id)
        }
    }
    
    func test_updateQuery(){
        sut.selectedTab = .joinedWorkspaces
        
        let mockWorkspace = Workspace(id: "2", accessCode: "321", name: "Workspace que sou PM", users: [PmMember(id: "2", userRole: "PRODUCT_MANAGER", userId: "1", workspaceId: "1", user: UserInfo(name: "Medeiros"))])
        let searchWorkspace = Workspace(id: "2", accessCode: "321", name: "teste que sou PM", users: [PmMember(id: "2", userRole: "PRODUCT_MANAGER", userId: "1", workspaceId: "1", user: UserInfo(name: "Medeiros"))])
        self.sut.workspaces = [mockWorkspace, mockWorkspace, mockWorkspace, searchWorkspace, searchWorkspace]
        self.sut.searchResults = self.sut.workspaces
        
        //Testar a busca com a query "teste"
        self.sut.query = "teste"
        self.sut.updateQuery()
        var searchWorkspacesCounter = self.sut.searchResults.count
        var expectedSearchWorkspacesCouter = 2
        XCTAssertEqual(searchWorkspacesCounter, expectedSearchWorkspacesCouter)
        
        //Testar quando a query está vazia
        self.sut.query = ""
        self.sut.updateQuery()
        searchWorkspacesCounter = self.sut.searchResults.count
        expectedSearchWorkspacesCouter = 5
        XCTAssertEqual(searchWorkspacesCounter, expectedSearchWorkspacesCouter)
    }
    
    
    
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
}
