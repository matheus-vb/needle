//
//  ProjectViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import Foundation

class ProjectViewModel: ObservableObject{
    @Published var selectedTab: SelectedTab = .Kanban 
    @Published var selectedProject: Workspace = Workspace(accessCode: "", name: "")
    @Published var projects: [Workspace] = [Workspace(accessCode: "Meu codigo 1", name: "Projeto 2"), Workspace(accessCode: "Meu codigo 2", name: "Projeto 1"), Workspace(accessCode: "Meu codigo 3", name: "Projeto 3"), Workspace(accessCode: "Meu codigo 4", name: "Projeto 4")]
}
