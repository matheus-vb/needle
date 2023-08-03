//
//  ProjectViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import Foundation

class ProjectViewModel: ObservableObject{
    @Published var selectedTab: SelectedTab = .Kanban // 1 -> Kanbar, 2 -> Documentation
    @Published var selectedProject: Workspace = Workspace(accessCode: "", name: "")
    @Published var projects: [Workspace] = [Workspace(accessCode: "Meu codigo", name: "Projeto 2"), Workspace(accessCode: "Meu codigo", name: "Projeto 1"), Workspace(accessCode: "Meu codigo", name: "Projeto 3"), Workspace(accessCode: "Meu codigo", name: "Projeto 4")]
}
