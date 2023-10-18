//
//  SheetView.swift
//  NeedleApp
//
//  Created by Bof on 04/08/23.
//

import Foundation
import SwiftUI
import Combine

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    // receber
    @EnvironmentObject var workspaceViewModel: WorkspaceHomeViewModel<WorkspaceDataService>
    @EnvironmentObject var projectViewModel: ProjectViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    @EnvironmentObject var editTaskViewModel: EditTaskViewModel<TaskDataService>
    @EnvironmentObject var kanbanViewModel: KanbanViewModel<TaskDataService>
    @EnvironmentObject var informationPageViewModel: InformationPageViewModel<TaskDataService, WorkspaceDataService, AuthenticationManager>
    @EnvironmentObject var rootViewModel: RootViewModel<AuthenticationManager, NotificationDataService, TaskDataService, WorkspaceDataService, UserDataService>
    
    @ObservedObject var workspaceDataService = WorkspaceDataService.shared
    @ObservedObject var authManager = AuthenticationManager.shared
    @ObservedObject var taskDataService = TaskDataService.shared
    @ObservedObject var documentDataService = DocumentationDataService.shared
    
    @State var isShowingError = false
    @State var showMain = true
    @State var isAnimating = false
    @State var action: () -> () = {}
    @State var accessCode = ""
    @State var textfieldInput: String = ""
    @State var selectedRole: Role = .DEVELOPER
    
    var type: SheetType
    
    var buttonAction: () -> () {
        switch type {
        case .deleteAccount: return {
            UserDataService.shared.deleteUser(userId: AuthenticationManager.shared.user!.id)
            self.authManager.user = nil
            dismiss()
        }
        case .newWorkspace: return {
            WorkspaceDataService.shared.createWorkspace(userId: AuthenticationManager.shared.user!.id, name: textfieldInput)
            dismiss()
            
        }
        case .deleteWorkspace: return {
            WorkspaceDataService.shared.deleteWorkspace(accessCode: workspaceViewModel.accessCode!, userId: AuthenticationManager.shared.user!.id)
            dismiss()
        }
            
        case .deleteWorkspaceFromInfo: return {
            WorkspaceDataService.shared.deleteWorkspace(accessCode: informationPageViewModel.workspace.accessCode, userId: AuthenticationManager.shared.user!.id)
            dismiss()
        }
            
        case .joinCode: return {
            WorkspaceDataService.shared.joinWorkspace(userId: AuthenticationManager.shared.user!.id, accessCode: textfieldInput, role:  selectedRole)
            
            dismiss()
            
        }
        case .shareCode: return {
            dismiss()
        }
        case .documentNotFound: return { dismiss() }
        case .deleteTask: return {
            editTaskViewModel.deleteTask()
            editTaskViewModel.isDeleting.toggle()
            editTaskViewModel.isEditing.toggle()
        }
        case .deleteTaskKanban: return {
            projectViewModel.deleteTask()
            projectViewModel.isDeleting.toggle()
        }
        case .loginError: return {dismiss()}
        case .archiveTask: return {
            taskDataService.updateTaskVisibility(taskId: editTaskViewModel.selectedTask.id, isVisible: editTaskViewModel.selectedTask.isVisible, userId: editTaskViewModel.userID, workspaceId: editTaskViewModel.workspaceID)
            dismiss()
        }
        case .archiveTaskKanban: return {
            taskDataService.updateTaskVisibility(taskId: projectViewModel.selectedTask!.id, isVisible: projectViewModel.selectedTask!.isVisible, userId: projectViewModel.userID, workspaceId: projectViewModel.selectedWorkspace.id)
            dismiss()
        }
        case .deleteWorkspaceMember: return {
            WorkspaceDataService.shared.deleteWorkspaceMember(userId: informationPageViewModel.getMemberId(), workspaceId: informationPageViewModel.workspace.id)
            
            dismiss()
        }
        }}
    
    var buttonBlock: some View {
        HStack(spacing: 8) {
            if type.twoButtons && type != .joinCode {
                Button(NSLocalizedString("Cancelar", comment: ""), action: {
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
                    Text(NSLocalizedString("Selecione uma função:", comment: ""))
                    Picker("", selection: $selectedRole) {
                        ForEach(Role.allCases.filter{ $0 != .PRODUCT_MANAGER }) { role in
                            Text(role.displayName).tag(role)
                        }
                    }.padding(.horizontal, 24)
                    
                    
                    
                    HStack {
                        Button(NSLocalizedString("Cancelar", comment: "")) {
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
            TextField(type == .newWorkspace ? NSLocalizedString("Insira o nome do novo workspace", comment: "") : "_ _ _ _ _ _", text: $textfieldInput)
                .onReceive(Just(textfieldInput)) { _ in
                    if type == .joinCode {
                        limitText(6)
                    }
                }
                .foregroundColor(.black)
                .frame(width: type == .joinCode ? 100 : 260)
            
        }
    }
    
    func limitText(_ upper: Int) {
        if textfieldInput.count > upper {
            textfieldInput = String(textfieldInput.prefix(upper))
        }
    }
    
    var errorMessage: some View {
        Text(NSLocalizedString("Algo deu errado. Tente novamente.", comment: ""))
            .font(.custom(SpaceGrotesk.regular.rawValue, size: 10)).foregroundColor(.red)
            .foregroundColor(.red)
    }
    
    var loading: some View {
        ZStack {
            HStack {
                Spacer()
                    .frame(maxWidth: .infinity)
                Image("Bg_Arte")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
            .frame(width: .infinity, height: .infinity)
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
                        .frame(width: 248, alignment: .center)
                        .multilineTextAlignment(.center)
                }
                
                if type == .joinCode || type == .newWorkspace {
                    textField
                }
                if type == .deleteAccount {
                    Link("Link", destination: URL(string: "https://support.apple.com/en-sg/HT210426")!)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .frame(width: 248, height: 32, alignment: .center)
                        .cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .inset(by: 0.5)
                                .stroke(.black, lineWidth: 1)
                        )
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
