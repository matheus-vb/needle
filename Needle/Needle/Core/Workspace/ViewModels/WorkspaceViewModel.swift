//
//  WorkspaceViewModel.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import Foundation
import SwiftUI

class WorkspaceViewModel: ObservableObject{
    @Published var workspaces: [Workspace] = []
    
    let workspaceService = WorkspaceService(baseUrl: _URL)
}
