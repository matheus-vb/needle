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

struct ChooseTemplateView: View {
    @Environment(\.dismiss) var dismiss
    //    @Binding var documentationNS: NSAttributedString
    //
    @State var chosenTemplate: TemplateType = .overview
    
    var backAction: () -> ()
    
    var closeAction: () -> ()
    
    var goToDocumentationAction: () -> ()
    
    var body: some View {
        VStack{
            header
            Divider()
            content
        }.background(.white)
            .foregroundColor(.black)
    }
    
    var header: some View {
        VStack {
            HStack {
                Button(action: {backAction()}, label: {Text("􀰪")})
                    .foregroundColor(.black)
                    .buttonStyle(.borderless)
                Spacer()
                Button(action: {closeAction()}, label: {Text("􀆄")})
                    .foregroundColor(.black)
                    .buttonStyle(.borderless)
            }.padding(.top, 16)
                .padding(.horizontal, 32)
            VStack(alignment: .center, spacing: 10) {
                Text(NSLocalizedString("Configure sua documentação", comment: ""))
                    .font(Font.custom("SF Pro", size: 24).weight(.medium))
                Text(NSLocalizedString("Escolha seu Template", comment: ""))
                    .font(Font.custom("SF Pro", size: 20).weight(.regular))
                
            }
        }
    }
    
    var content: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("Modelos disponíveis", comment: ""))
                    .font(Font.custom("SF Pro", size: 16).weight(.semibold))
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(TemplateArea.allCases, id: \.rawValue) { area in
                            VStack(alignment: .leading, spacing: 16) {
                                Text(area.areaName)
                                ForEach(TemplateType.allCases.filter({ $0.info.area == area }), id: \.rawValue) { item in
                                    Button(action: {chosenTemplate = item}, label: {
                                        Text(item.info.name)
                                    }).buttonStyle(ChooseTemplateButton())
                                }
                            }
                        }
                    }.padding(.trailing, 20)
                        .foregroundColor(.black)
                }
            }.padding(.top, 16)
                .padding(.leading, 24)
            Divider()
                .padding(.horizontal, 24)
            VStack(alignment: .trailing, spacing: 32) {
                templateVisualizer
                //                        .frame(width: geometry.size.width*0.60)
                    .padding(.leading, 4)
                createButton
                Spacer()
            }.padding(.top, 16)
            Spacer()
                .frame(width: 20)
        }
    }
    
    
    var templateVisualizer: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(NSLocalizedString("Pré-visualização:", comment: "")).font(Font.custom("SF Pro", size: 16)
                .weight(.semibold)) + Text(" ")
            + Text(chosenTemplate.info.name).font((Font.custom("SF Pro", size: 16).weight(.semibold)))
            Image(chosenTemplate.info.img)
                .resizable()
                .scaledToFit()
        }
    }
    
    
    var createButton: some View {
        Button(action: { dismiss()
            goToDocumentationAction()}, label: {
                Text(NSLocalizedString("Criar", comment: ""))
            })
        .buttonStyle(CreateTemplateButton())
    }
}


