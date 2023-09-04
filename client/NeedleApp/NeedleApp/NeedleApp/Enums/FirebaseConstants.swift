//
//  FirebaseConstants.swift
//  NeedleApp
//
//  Created by Jpsmor on 25/08/23.
//

import SwiftUI

enum K: String {
    case tapAddTask = "tappedAddTask" //implementado
    case addedTask = "addedTask"  //implementado
    case nonPMTriedToAddConcluded = "nonPMTriedToAddConclude"  //implementado
    case createWorkspaceTapped = "tappedCreateWorkspace"   //implementado
    case createdWorkspace = "createdWorkspace"
    case errorToCreateWorkspace = "errorToCreateWorkspace"
    case joinWorkspaceTapped = "tappedJoinWorkspace"  //implementado
    case joinedWorkspace = "joinedWorkspace"
    case errorToJoinWorkspace = "errorToJoinWorkspace"
    case deleteWorkspaceTapped = "tappedDeleteWorkspace"
    case deletedWorkspadce = "deletedWorkspace"
    case changeWorkspace = "changedWorkspaceBySideBar" //implementado
    case viewedTask = "viewedTask"
    case movedTask = "movedTask"  //implementado
    case changedTaskStatus = "changedTaskStatus"  //implementado
    case copiedJoinCode = "copiedJoinCode"  // implementado
    case nonPMTriedToConclude = "nonPMTriedToConclude"
}
