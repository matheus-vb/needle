//
//  LeftSideComponent.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectLeftSideComponent: View {
    @EnvironmentObject var projectViewModel: ProjectViewModel
    var body: some View {
        VStack(spacing: 75){
            leftSideTitle
            projectsList
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct LeftSideComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProjectLeftSideComponent()
    }
}
