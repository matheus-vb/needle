//
//  KanbanViewModel.swift
//  Needle
//
//  Created by gabrielfelipo on 29/05/23.
//
import Foundation
import SwiftUI

extension KanbanView {
    @MainActor class KanbanViewModel: ObservableObject {
        
        let workspace: Workspace
        
        init(workspace: Workspace) {
            self.workspace = workspace
        }
        
        @Published var minScale = 0.7
        @Published var maxScale = 1.5
        
        @Published var scale = 1.0
        @Published var finalScale: CGFloat = 1
        @State var geometryHeight: Double = 0.0
        
        struct InitialButtonStyle: ButtonStyle {
            
            func makeBody(configuration: Self.Configuration) -> some View {
                configuration.label
                    .foregroundColor(.black)
                    .background(Color.color.kanbanGray)
                    .cornerRadius(10)
            }
        }
        
        var magnification: some Gesture {
            MagnificationGesture()
                .onChanged{ state in
                    self.adjustScale(from: state)
                }
                .onEnded{ state in
                    withAnimation{
                        self.validateScaleLimits()
                    }
                    self.finalScale = 1.0
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
}

