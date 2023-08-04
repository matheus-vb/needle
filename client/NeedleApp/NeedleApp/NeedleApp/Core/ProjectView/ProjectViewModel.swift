//
//  ProjectViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import Foundation

class ProjectViewModel: ObservableObject{
    @Published var selectedTab: SelectedTab = .Kanban 
    @Published var selectedProject: Workspace = Workspace(id: "id1", accessCode: "", name: "")
    @Published var projects: [Workspace] = []
}
