//
//  Placeholderview.swift
//  NeedleApp
//
//  Created by Bof on 02/08/23.
//

import Foundation
import SwiftUI

struct NotifCard: View {
    var username = "Fulano de Tal"
    var action = " aceitou sua documentação de "
    var task = "Rever backlog."
    var projectName = "Marketing"
    var timeAgo = "há 30 minutos"

    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(username + action + task)
            HStack {
                Text("Projeto " + projectName + "  ·  " + timeAgo).font(.footnote)
                
            }
        }.foregroundColor(.black)
        .frame(width: 244)
    }
}

struct NotifCard_Previews: PreviewProvider {
    static var previews: some View {
        NotifCard().background(.white)
    }
}
