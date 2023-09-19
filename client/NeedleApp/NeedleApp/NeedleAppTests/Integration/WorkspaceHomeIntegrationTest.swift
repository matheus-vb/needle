//
//  WorkspaceHomeViewTests.swift
//  NeedleAppUITests
//
//  Created by jpcm2 on 19/09/23.
//

import XCTest
import Firebase

final class WorkspaceHomeViewTests: XCTestCase {
    var dbMock: DBMock!
    var workspaceDS: WorkspaceDataServiceMock!
    var sut: WorkspaceHomeViewModel<WorkspaceDataServiceMock>!
    
    override func setUpWithError() throws {
        self.dbMock = DBMock()
        self.workspaceDS = WorkspaceDataServiceMock(db: dbMock)
        self.sut = WorkspaceHomeViewModel(workspaceDS: workspaceDS)
    }

    override func tearDownWithError() throws {
        dbMock = nil
        workspaceDS = nil
        workspaceDS = nil
    }
    

    func testExample() throws {
        let view = WorkspaceHomeView(workspaceViewModel: sut)
    
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
