//
//  ProjectViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import Foundation

class ProjectViewModel: ObservableObject{
    @Published var selectedTab: SelectedTab = .Kanban // 1 -> Kanbar, 2 -> Documentation
}
