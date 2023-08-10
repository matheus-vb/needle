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
        case .loginError: return {dismiss()}

        }
    }
        
    var buttonBlock: some View {
      HStack(spacing: 16) {
          if type.twoButtons && type != .joinCode {
                    Button("Cancelar", action: {
                        dismiss()
                    }).buttonStyle(SecondarySheetActionButton())
                    
                    Button(type.primaryAction, action: {
                        buttonAction()
                    }).buttonStyle(PrimarySheetActionButton())
                }
          else if type == .joinCode {
                  VStack(spacing: 20) {
                      
                      Picker("Selecione uma função: ", selection: $selectedRole) {
                          ForEach(Role.allCases.filter{ $0 != .PRODUCT_MANAGER }) { role in
                              Text(role.displayName).tag(role)
                          }
                      }.padding(.horizontal, 24)

                      
                      
                      HStack {
                          Button("Cancelar") {
                              dismiss()
                          }
                          .buttonStyle(SecondarySheetActionButton())
                          Button("Entrar") {
                              WorkspaceDataService.shared.joinWorkspace(userId: AuthenticationManager.shared.user!.id, accessCode: textfieldInput, role: selectedRole)
                              
                              showMain.toggle()

                          }.buttonStyle(PrimarySheetActionButton())
                          
                      }
                  }
                  .offset(y: -20)
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
            .font(.custom(SpaceGrotesk.regular.rawValue, size: 10)).foregroundColor(.red)
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
        }

    }
    
    var main: some View {
        VStack(spacing: 4) {
            type.image
            if isShowingError {
                errorMessage
            }
                VStack(spacing: 12) {
                    if type.title != ""{
                        Text(type.title)
                            .font(.custom("SF Pro", size: 16))
                            .bold()
                            .padding(.top, 8)
                    }
                    if type.text != ""{
                        Text(type.text)
                            .font(.custom("SF Pro", size: 14))
                            .multilineTextAlignment(.center)
                    }
                
                if type == .joinCode || type == .newWorkspace {
                    textField
                }
            
            }
            buttonBlock
                .padding(.top, type == .joinCode ? 20 : 16)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 35.5)

        .foregroundColor(.black)
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
        }.frame(width: type.width, height: type.height)
        .onChange(of: auth.errorCount, perform: { _ in
            isShowingError.toggle()
        })
    }
    
    func loadData() async {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        withAnimation {
            showMain = true
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 8) {
            SheetView(type: .loginError)
                .background(.white)
            SheetView(type: .deleteWorkspace)
                .background(.white)

            SheetView(type: .documentNotFound)
                .background(.white)

            SheetView(type: .joinCode)
                .background(.white)

            SheetView(type: .newWorkspace)
                .background(.white)

            SheetView(type: .shareCode)
                .background(.white)


        }.background(.pink)
    }
}
