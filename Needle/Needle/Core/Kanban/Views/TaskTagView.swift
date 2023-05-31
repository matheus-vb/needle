//
//  TaskTagView.swift
//  Needle
//
//  Created by gabrielfelipo on 26/05/23.
//

import SwiftUI

struct TaskTagView: View {
    
    let tagType: String
    
    var body: some View {
        if tagType == "dev" {
            HStack{
                Text("membro")
                    .font(.custom(.spaceGrotesk, size: 13))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                    .background(Color(red: 0.89, green: 0.89, blue: 0.89)).cornerRadius(4)
                
                Text("dev")
                    .font(.custom(.spaceGrotesk, size: 13))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                    .background(Color(red: 0.52, green: 0.67, blue: 0.97)).cornerRadius(4)
            }
        }
        else if tagType == "design" {
            HStack{
                Text("membro")
                    .font(.custom(.spaceGrotesk, size: 13))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 0.89, green: 0.89, blue: 0.89)).cornerRadius(4)
                
                Text("design")
                    .font(.custom(.spaceGrotesk, size: 13))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 0.87, green: 0.78, blue: 1.00)).cornerRadius(4)
            }
        }
        else {
            Text(tagType)
                .font(.custom(.spaceGrotesk, size: 13))
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color(red: 0.99, green: 0.59, blue: 0.22)).cornerRadius(4)
        }
        
        
    }
}

struct TaskTagView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTagView(tagType: "dev")
    }
}
