//
//  TitleSideBarCriarTask.swift
//  Needle
//
//  Created by gabrielfelipo on 31/05/23.
//

import SwiftUI

struct TitleSideBarCriarTask: View {
    var body: some View {
        VStack{
            Spacer().frame(minHeight: 28, idealHeight: 82, maxHeight: 82)
            HStack{
                Spacer().frame(idealWidth: 87)
                Text("Atributos")
                    .font(.custom(.spaceGroteskBold, size: 24))
                
                Spacer().frame(idealWidth: 250)
                
                Image(systemName: "rectangle.3.group.fill")
                    .resizable()
                    .frame(width: 36, height: 24)
                
                Spacer().frame(idealWidth: 100)
            }
            Spacer().frame(height: 30)
        }
    }
}

struct TitleSideBarCriarTask_Previews: PreviewProvider {
    static var previews: some View {
        TitleSideBarCriarTask()
    }
}
