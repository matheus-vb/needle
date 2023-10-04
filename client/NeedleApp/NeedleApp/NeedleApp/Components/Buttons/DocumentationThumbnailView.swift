//
//  DocumentationThumbnailView.swift
//  NeedleApp
//
//  Created by aaav on 04/10/23.
//

import SwiftUI

struct DocumentationThumbnailView: View {
    var image : String = "checkmark.square.fill"
    var image2 : String = "arrow.counterclockwise.circle.fill"
    var image3 : String = "clock.fill"
    var documentationName : String = "Documentation"
    var documentationOwner : String = "Mister Owner"
    
    var body: some View {
        
        VStack{
            HStack{
                Spacer()
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.green)
                    .padding(8)
            }
            
            Spacer()
            VStack(alignment: .leading) {
                Text(documentationName)
                    .font(.custom("SF Pro", size: 12))
                    .foregroundColor(.white)
                Text(documentationOwner)
                    .foregroundColor(.white)
                        .font(.custom("SF Pro", size: 10))
            }
            .padding(.leading, 16)
            .frame(width: 286,height: 35, alignment: .leading)
            .background(Color.theme.grayHover)
            
            
        }
        .background(.white)
        .frame(width: 286, height: 179)
        .cornerRadius(6)
        
    }
}

struct DocumentationThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationThumbnailView()
    }
}
