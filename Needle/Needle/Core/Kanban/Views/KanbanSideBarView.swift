//
//  KanbanSideBarView.swift
//  Needle
//
//  Created by gabrielfelipo on 29/05/23.
//

import SwiftUI

struct KanbanSideBarView: View {
    var body: some View {
        VStack{
            Spacer().frame(height: 41)
            
            Text("Needle")
            
            Spacer().frame(height: 50)
            
            Text("Home")
            
            Spacer()
            
            VStack{
                Circle().frame(height: 46)
                
                Spacer().frame(height: 20)
                
                Circle().frame(height: 46)
            }
            
            Spacer().frame(height: 120)
            Spacer()
            
            Circle().frame(height: 46)
            
            Spacer().frame(height: 87)
            
        }.frame(width: 170)
        .background(.black)
    }
}

struct KanbanSideBarView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanSideBarView()
    }
}
