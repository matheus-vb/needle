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
            HStack {
                Text(NSLocalizedString("Configure sua documentação", comment: ""))
                Text(NSLocalizedString("Escolha seu Template", comment: ""))
            }
        }
    }
    
    var content: some View {
        HStack {
            templatePicker
            VStack {
                templateVisualizer
                createButton
            }
        }
    }
    
    var templatePicker: some View {
        ScrollView {
            VStack {
            
            }   
        }
    }
    
    var templateVisualizer: some View {
        VStack {
            
        }
    }
    
    
    var createButton: some View {
        VStack {
            
        }
    }
}
