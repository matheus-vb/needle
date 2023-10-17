//
//  DeleteAccountSheet.swift
//  NeedleApp
//
//  Created by jpcm2 on 10/10/23.
//

import SwiftUI

struct DeleteAccountSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var workspaceDataService = WorkspaceDataService.shared
    @ObservedObject var authManager = AuthenticationManager.shared
    @ObservedObject var taskDataService = TaskDataService.shared
    @ObservedObject var documentDataService = DocumentationDataService.shared
    
    @State var isShowingError = false
    @State var showMain = true
    @State var isAnimating = false
    @State var textfieldInput: String = ""
    
    @Binding var logout: Bool
    
    var buttonBlock: some View {
        HStack(spacing: 8) {
            Button(NSLocalizedString("Cancelar", comment: ""), action: {
                dismiss()
            }).buttonStyle(SecondarySheetActionButton())
            
            Button(NSLocalizedString("Desativar", comment: ""), action: {
                logout.toggle()
                UserDataService.shared.deleteUser(userId: AuthenticationManager.shared.user!.id)
                self.authManager.user = nil
                dismiss()
                logout.toggle()
            }).buttonStyle(PrimarySheetActionButton())
                .keyboardShortcut(.defaultAction)
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
            Image("delete_user")
            if isShowingError {
                errorMessage
            }
            VStack(spacing: 12) {
                Text(NSLocalizedString("Excluir conta?", comment: ""))
                    .font(.custom("SF Pro", size: 16))
                    .bold()
                    .padding(.top, 8)
                
                Text(NSLocalizedString("Ao excluir sua conta você perde\n o acesso a todos os seus projetos. Lembre-se desvincular o app do seu Sign In with Apple caso queira criar uma nova conta clicando no link abaixo.", comment: ""))
                    .font(.custom("SF Pro", size: 14))
                    .frame(width: 248, alignment: .center)
                    .multilineTextAlignment(.center)
            
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
            buttonBlock
                .padding(.top, 16)
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
        }
    }
    
    func loadData() async {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        withAnimation {
            showMain = true
        }
    }
}
