//
//  ChooseTemplateView.swift
//  NeedleApp
//
//  Created by Bof on 05/10/23.
//

import Foundation
import SwiftUI

struct ChooseTemplateButton: ButtonStyle {
    var onHover = false
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .stroke(lineWidth: 0.63)
                .foregroundStyle(.black)
            configuration.label
                .foregroundStyle(.black)
                .padding(.vertical, 6.26)
                .padding(.horizontal, 6.26)
        }
        .font(.custom("SF Pro", size: 14))
        
        .background(onHover ? Color.theme.greenSecondary : .white)
        .frame(width: 210, height: 35)
    }
}

struct CreateTemplateButton: ButtonStyle {
    var onHover = false
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .background(.black)
            configuration.label
                .foregroundStyle(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
        }
        .font(.custom("SF Pro", size: 14))
        .cornerRadius(6)
        .frame(width: 104, height: 32)
    }
}

