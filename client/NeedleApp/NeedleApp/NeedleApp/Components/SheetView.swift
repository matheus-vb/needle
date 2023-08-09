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
    @ObservedObject var auth = WorkspaceDataService.shared
    
    @State var isShowingError = false
    
    @State var showMain = true
    @State var isAnimating = false
    
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
                          Button("Cancelar") {
                              dismiss()
                          }.buttonStyle(SecondarySheetActionButton())
                          Button("Entrar") {
                              WorkspaceDataService.shared.joinWorkspace(userId: AuthenticationManager.shared.user!.id, accessCode: textfieldInput, role: selectedRole)
                              
                              showMain.toggle()

                          }.buttonStyle(PrimarySheetActionButton())
                          
                      }
                  }
                  .offset(y: -20)
                  .padding(.horizontal, 40)
                  .padding(.vertical, 10)
          }
                else   {
                    Spacer()
                    Button("Ok", action: {
                        showMain.toggle()
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
                .frame(width: type == .joinCode ? 100 : 260)


        }
    }
    
    var errorMessage: some View {
        Text("Algo deu errado. Tente novamente.")
            .font(.custom(SpaceGrotesk.regular.rawValue, size: 16)).foregroundColor(.red)
            .foregroundColor(.red)
    }
    
    var loading: some View {
        ZStack {
            Image("icon-bg")
                .offset(x: 200, y: 40)
                .blur(radius: 8)
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color.theme.greenMain, lineWidth: 4)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .onAppear() {
                    withAnimation (.linear(duration: 1).repeatForever(autoreverses: false)) {
                        self.isAnimating.toggle()
                    }
                }
        }.frame(width: 328, height: 264)

    }
    
    var main: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                type.image
                Text(type.title).font(.title)
                Text(type.text)
                    .multilineTextAlignment(.center)
                    .frame(height: 40)
                textField
                    .opacity((type == .joinCode || type == .newWorkspace) ? 1.0 : 0.0)
                
            }
            buttonBlock
            errorMessage.opacity(isShowingError ? 1.0 : 0.0)
                .offset(y: -4)
        }
        .frame(width: 328, height: 264)
        .foregroundColor(.black)
        .padding(.horizontal, 40)
        .padding(.top, 40)
    }
    
    var body: some View {
        ZStack {
            if showMain {
                main
            } else {
                loading
                    .onAppear {
                        Task {
                            await loadData()
                        }
                    }
            }
        }
        .onChange(of: auth.errorCount, perform: { _ in
            isShowingError.toggle()
        })
    }
    
    func loadData() async {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        withAnimation {
            showMain = true
//            dismiss()
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(type: .deleteTask)
            .background(.white)

    }
}
