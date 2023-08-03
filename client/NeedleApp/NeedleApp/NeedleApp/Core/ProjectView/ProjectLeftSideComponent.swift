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
        VStack{
            leftSideTitle
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
