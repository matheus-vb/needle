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
    @EnvironmentObject var workspaceViewModel: WorkspaceHomeViewModel<WorkspaceDataService>
    @EnvironmentObject var projectViewModel: ProjectViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    @EnvironmentObject var editTaskViewModel: EditTaskViewModel<DocumentationDataService, TaskDataService>
    
    @ObservedObject var workspaceDataService = WorkspaceDataService.shared
    @ObservedObject var authManager = AuthenticationManager.shared
    @ObservedObject var taskDataService = TaskDataService.shared
    @ObservedObject var documentDataService = DocumentationDataService.shared
    
    @State var isShowingError = false
    
    @State var showMain = true
    @State var isAnimating = false
    
    @State var action: () -> () = {}
    
    @State var accessCode = ""
    
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
        case .deleteWorkspace: return {                     WorkspaceDataService.shared.deleteWorkspace(accessCode: workspaceViewModel.accessCode!, userId: AuthenticationManager.shared.user!.id)
            dismiss()
            
        }
        case .joinCode: return {
            WorkspaceDataService.shared.joinWorkspace(userId: AuthenticationManager.shared.user!.id, accessCode: textfieldInput, role:  selectedRole)
            
            dismiss()
            
        }
        case .shareCode: return {
            dismiss()
            //            pasteboard.string = textfieldInput
        }
        case .documentNotFound: return { dismiss() }
        case .deleteTask: return {
            projectViewModel.deleteTask()
            editTaskViewModel.isDeleting.toggle()
            projectViewModel.showEditTaskPopUP.toggle()
        }
        case .loginError: return {dismiss()}
        case .archiveTask: return {
            taskDataService.updateTaskStatus(taskId: projectViewModel.selectedTask!.id, status: .NOT_VISIBLE, userId: projectViewModel.userID, workspaceId: projectViewModel.selectedWorkspace.id)
            dismiss()
        }

        }
    }
        
    var buttonBlock: some View {
      HStack(spacing: 8) {
          if type.twoButtons && type != .joinCode {
                    Button("Cancelar", action: {
                        if(type == .deleteTask){
                            editTaskViewModel.isDeleting.toggle()
                        }else{
                            dismiss()
                        }
                    }).buttonStyle(SecondarySheetActionButton())
                    
                    Button(type.primaryAction, action: {
                        buttonAction()
                    }).buttonStyle(PrimarySheetActionButton())
                  .keyboardShortcut(.defaultAction)
                }
          else if type == .joinCode {
                  VStack(spacing: 10) {
                      Text("Selecione uma função:")
                      Picker("", selection: $selectedRole) {
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
                              .keyboardShortcut(.defaultAction)
                      }
                  }
                  .offset(y: -20)
                  .padding(.vertical, 10)
          }
                else   {
                    Spacer()
                    Button("Ok", action: {
                        buttonAction()
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
                .stroke(Color.theme.blackMain, lineWidth: 4)
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
                    if type.title != "" {
                        Text(type == .shareCode ? accessCode : type.title)
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
        .onChange(of: workspaceDataService.errorCount, perform: { _ in
            isShowingError.toggle()
        })
        .onChange(of: taskDataService.errorCount, perform: { _ in
            isShowingError.toggle()
        })
        .onChange(of: authManager.errorCount, perform: { _ in
            isShowingError.toggle()
        })
        .onChange(of: documentDataService.errorCount, perform: { _ in
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
            
            SheetView(type: .archiveTask)
                .background(.white)
            
            SheetView(type: .deleteTask)
                .background(.white)


        }.background(.pink)
    }
}
