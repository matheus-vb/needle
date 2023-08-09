//
//  SheetView.swift
//  NeedleApp
//
//  Created by Bof on 04/08/23.
//

import Foundation
import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: WorkspaceHomeViewModel
    @EnvironmentObject var projectViewModel: ProjectViewModel

    
//    let pasteboard = Pasteboard()
    
    @State var textfieldInput: String = ""
    @State var selectedRole: Role = .DEVELOPER

    
    var type: SheetType
    
    var buttonAction: () -> () {
        switch type {
        case .newWorkspace: return {
            WorkspaceDataService.shared.createWorkspace(userId: AuthenticationManager.shared.user!.id, name: textfieldInput)
            
            dismiss()
            
        }
        case .deleteWorkspace: return {                     WorkspaceDataService.shared.deleteWorkspace(accessCode: viewModel.accessCode!, userId: AuthenticationManager.shared.user!.id)
            dismiss()
            
        }
        case .joinCode: return {
            WorkspaceDataService.shared.joinWorkspace(userId: AuthenticationManager.shared.user!.id, accessCode: textfieldInput, role:  selectedRole)
            
            dismiss()
            
        }
        case .shareCode: return {
//            pasteboard.string = textfieldInput
        }
        case .documentNotFound: return { dismiss() }
        case .deleteTask: return { dismiss() } // pegar rota c matheus
        }
    }
        
    var buttonBlock: some View {
      HStack(spacing: 40) {
          if type.twoButtons && type != .joinCode {
                    Button("Cancelar", action: {
                        dismiss()
                    }).buttonStyle(SecondarySheetActionButton())
                    
                    Button(type.primaryAction, action: {
                        buttonAction()
                    }).buttonStyle(PrimarySheetActionButton())
                }
          else if type == .joinCode {
                  VStack(spacing: 24) {
                      
                      Picker("Selecione uma função", selection: $selectedRole) {
                          ForEach(Role.allCases.filter{ $0 != .PRODUCT_MANAGER }) { role in
                              Text(role.displayName).tag(role)
                          }
                      }
                      
                      
                      HStack {
                          PopUpButton(text: "Cancelar") {
                              dismiss()
                          }
                          PopUpButton(text: "Entrar") {
                              WorkspaceDataService.shared.joinWorkspace(userId: AuthenticationManager.shared.user!.id, accessCode: textfieldInput, role: selectedRole)
                              
                              dismiss()
                          }
                          
                      }
                  }
                  .padding(.horizontal, 40)
                  .padding(.vertical, 10)
          }
                else   {
                    Spacer()
                    Button("Ok", action: {
                        dismiss()
                    }).buttonStyle(PrimarySheetActionButton())
                    Spacer()
                }
            }
        }
    
    var textField: some View {
        HStack {
            Text("#").opacity(type == .joinCode ? 1.0 : 0.0).font(.title)
            TextField(type == .newWorkspace ? "Insira o nome do novo workspace" : "_ _ _ _ _ _", text: $textfieldInput)
                .foregroundColor(.black)
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                type.image
                Text(type.title).font(.title)
                textField
                    .frame(width:100)
                    .opacity((type == .joinCode || type == .newWorkspace) ? 1.0 : 0.0)
                Text(type.text)
                    .multilineTextAlignment(.center)
            }
            buttonBlock
        }
        .frame(width: 328, height: 264)
        .foregroundColor(.black)
        .padding(.horizontal, 40)
        .padding(.vertical, 32)}
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(type: .joinCode)
            .background(.white)

    }
}
