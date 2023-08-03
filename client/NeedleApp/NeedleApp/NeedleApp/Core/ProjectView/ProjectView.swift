//
//  ProjectView.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectView: View {
    var body: some View {
        NavigationSplitView(sidebar: {
            ProjectLeftSideComponent()
                .padding(.top, 62)
                .background(Color("BG"))
        }, detail: {
            Text("Hello world")
        })
        .ignoresSafeArea()
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
