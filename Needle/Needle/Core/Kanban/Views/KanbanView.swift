//
//  KanbanView.swift
//  Needle
//
//  Created by gabrielfelipo on 26/05/23.
//

import SwiftUI

struct KanbanView: View {
    @State private var finalScale: CGFloat = 1
    @State private var scale = 1.0
    private let minScale = 0.7
    private let maxScale = 1.5
    
    let workspace: WorkspaceModel
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged{ state in
                adjustScale(from: state)
            }
            .onEnded{ state in
                withAnimation{
                    validateScaleLimits()
                }
                finalScale = 1.0
            }
    }
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack{
                Text(workspace.name)
                KanbanComponentView()
            }.background(.white)
            .scaleEffect(scale)
                .gesture(magnification)
        }
    }
    
    func adjustScale(from state: MagnificationGesture.Value) {
        let delta = state / finalScale
        scale *= delta
        finalScale = state
    }
    
    func getMinimumScaleAllowed() -> CGFloat {
        return max(scale, minScale)
    }
    
    func getMaximumScaleAllowed() -> CGFloat {
        return min(scale, maxScale)
    }
    
    func validateScaleLimits() {
        scale = getMinimumScaleAllowed()
        scale = getMaximumScaleAllowed()
    }
}

struct KanbanView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanView(workspace: WorkspaceModel(id: "1", accessCode: "123", name: "Projeto Teste"))
    }
}
