//
//  ChooseTemplateView.swift
//  NeedleApp
//
//  Created by Bof on 05/10/23.
//

import Foundation
import SwiftUI

struct ChooseTemplateView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var documentationNS: NSAttributedString
    
    @State var chosenTemplate: TemplateType = .overview

    
    var geometry: GeometryProxy

    var action: () -> ()
        
    init(workspaceId: String, documentId: String, documentationNS: Binding<NSAttributedString>,  action: @escaping () -> (), geometry: GeometryProxy) {
        self.action = action
//        self._editTaskViewModel = StateObject(wrappedValue: editTaskViewModel)
        self._documentationNS = documentationNS
        self.geometry = geometry
    }

    var body: some View {
        VStack{
            header
            content
        }
    }
    
    var header: some View {
        VStack {
            HStack {
                Text("􀰪")
                Spacer()
                Text("􀆄")
            }.padding(.top, 16)
            .padding(.horizontal, 32)
            VStack(alignment: .center) {
                Text(NSLocalizedString("Configure sua documentação", comment: ""))
                Text(NSLocalizedString("Escolha seu Template", comment: ""))
            }
        }
    }
    
    var content: some View {
        HStack {
            templatePicker
            VStack(alignment: .trailing) {
                templateVisualizer
                createButton
            }
        }
    }
    
    var templatePicker: some View {
        ScrollView {
            VStack {
                ForEach(TemplateArea.allCases, id: \.rawValue) { area in
                    VStack {
                        Text(area.rawValue)
                        ForEach(TemplateType.allCases.filter({ $0.info.area == area }), id: \.rawValue) { item in
                            Button(action: {chosenTemplate = item}, label: { Text(item.info.name) })
                        }
                    }
                }   
            }
        }
    }
    
    var templateVisualizer: some View {
        VStack(alignment: .leading) {
            Text(chosenTemplate.info.name)
            Image(chosenTemplate.info.img)
        }
    }
    
    
    var createButton: some View {
        Button(action: {}, label: {
            Text(NSLocalizedString("Criar", comment: ""))
        })
    }
}
