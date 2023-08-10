//
//  LabelComponent.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI

struct LabelComponent: View {
    let imageName: String
    let label: String
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20, height: 20)
            Text(label)
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.grayPressed)
    }
}
