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
            Text("Hello world")
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
