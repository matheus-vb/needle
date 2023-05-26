//
//  TaskTagView.swift
//  Needle
//
//  Created by gabrielfelipo on 26/05/23.
//

import SwiftUI

struct TaskTagView: View {
    enum tagTypeEnum {
        case dev
        case design
        case pm
    }
    
    let tagType: tagTypeEnum
    
    var body: some View {
        if tagType == .dev{
            HStack{
                Text("membro")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 0.89, green: 0.89, blue: 0.89)).cornerRadius(4)
                
                Text("dev")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 0.52, green: 0.67, blue: 0.97)).cornerRadius(4)
            }
        }
        else if tagType == .design {
            HStack{
                Text("membro")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 0.89, green: 0.89, blue: 0.89)).cornerRadius(4)
                
                Text("design")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 0.87, green: 0.78, blue: 1.00)).cornerRadius(4)
            }
        }
        else {
            Text("PM")
                .font(.system(size: 13))
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color(.orange)).cornerRadius(4)
        }
        
        
    }
}

struct TaskTagView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTagView(tagType: .dev)
    }
}
