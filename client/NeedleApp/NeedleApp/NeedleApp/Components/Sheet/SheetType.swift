//
//  SheetType.swift
//  NeedleApp
//
//  Created by Bof on 09/08/23.
//

import Foundation
import SwiftUI

enum SheetType {
    case deleteAccount, newWorkspace, deleteWorkspace, joinCode, shareCode, documentNotFound, deleteTask, loginError, archiveTask, deleteWorkspaceMember, deleteWorkspaceFromInfo, archiveTaskKanban, deleteTaskKanban
    
    var image: Image {
        switch self {
        case .deleteAccount: return Image("delete_user")
        case .newWorkspace: return Image("NewWorkspace")
        case .deleteWorkspace: return Image("DeleteWorkspace")
        case .deleteWorkspaceFromInfo: return Image("DeleteWorkspace")
        case .joinCode: return Image("JoinCode")
        case .shareCode: return Image("ShareCode")
        case .documentNotFound: return Image("DocumentNotFound")
        case .deleteTask: return Image("DeleteWorkspace")
        case .loginError: return Image("LoginError")
        case .archiveTask: return Image("CleanTask")
        case .deleteWorkspaceMember: return Image("DeleteWorkspaceMember")
        case .archiveTaskKanban: return Image("CleanTask")
        case .deleteTaskKanban: return Image("DeleteWorkspace")
            
            
        }
    }
    
    var title: String {
        switch self {
        case .deleteAccount: return NSLocalizedString("Excluir conta?", comment: "")
        case .newWorkspace: return ""
        case .deleteWorkspace:return NSLocalizedString("Excluir projeto?", comment: "")
        case .deleteWorkspaceFromInfo:return NSLocalizedString("Excluir projeto?", comment: "")
        case .joinCode: return ""
        case .shareCode: return ""
        case .documentNotFound: return NSLocalizedString("Documento não encontrado", comment: "")
        case .deleteTask: return NSLocalizedString("Deletar task?", comment: "")
        case .loginError: return ""
        case .archiveTask: return NSLocalizedString("Arquivar task?", comment: "")
        case .deleteWorkspaceMember: return NSLocalizedString("Excluir usuário?", comment: "")
        case .archiveTaskKanban: return NSLocalizedString("Arquivar task?", comment: "")
        case .deleteTaskKanban: return NSLocalizedString("Deletar task?", comment: "")
        }
    }
    
    var text: String {
        switch self {
        case .deleteAccount: return NSLocalizedString("Ao excluir sua conta você perde\n o acesso a todos os seus projetos. Lembre-se desvincular o app do seu Sign In with Apple caso queira criar uma nova conta clicando no link abaixo.", comment: "")
        case .newWorkspace: return NSLocalizedString("Nomeie seu novo workspace:", comment: "")
        case .deleteWorkspace: return NSLocalizedString("Lembre-se, ao excluir um workspace,\nsuas tasks e documentos serão perdidos.", comment: "")
        case .deleteWorkspaceFromInfo: return NSLocalizedString("Lembre-se, ao excluir um workspace,\nsuas tasks e documentos serão perdidos.", comment: "")
        case .joinCode: return ""
        case .shareCode: return NSLocalizedString("Envie o código do workspace para sua equipe e deixe-a alinhada.", comment: "")
        case .documentNotFound: return NSLocalizedString("Procure por outras palavras-chave como título da task, área ou data!", comment: "")
        case .deleteTask: return NSLocalizedString("Sua task e a documentação serão excluídas para sempre.", comment: "")
        case .loginError: return NSLocalizedString("Tente novamente.", comment: "")
        case .archiveTask: return NSLocalizedString("Sua task será removida do kanban, mas sua documentação continuará acessível.", comment: "")
        case .deleteWorkspaceMember: return NSLocalizedString("Esse usuário não irá mais estar disponível neste workspace.", comment: "")
        case .deleteTaskKanban: return NSLocalizedString("Sua task e a documentação serão excluídas para sempre.", comment: "")
        case .archiveTaskKanban: return NSLocalizedString("Sua task será removida do kanban, mas sua documentação continuará acessível.", comment: "")
        }
    }
    
    var twoButtons: Bool {
        switch self {
        case .deleteAccount: return true
        case .newWorkspace: return true
        case .deleteWorkspace: return true
        case .deleteWorkspaceFromInfo: return true
        case .joinCode: return true
        case .shareCode: return true
        case .documentNotFound: return false
        case .deleteTask: return true
        case .loginError: return false
        case .archiveTask: return true
        case .deleteWorkspaceMember: return true
        case .deleteTaskKanban: return true
        case .archiveTaskKanban: return true
        }
    }
    
    var primaryAction: String {
        switch self {
        case .deleteAccount: return NSLocalizedString("Desativar", comment: "")
        case .newWorkspace: return NSLocalizedString("Criar", comment: "")
        case .deleteWorkspace: return NSLocalizedString("Excluir", comment: "")
        case .deleteWorkspaceFromInfo: return NSLocalizedString("Excluir", comment: "")
        case .joinCode: return NSLocalizedString("Entrar", comment: "")
        case .shareCode: return NSLocalizedString("Copiar", comment: "")
        case .documentNotFound: return "Ok"
        case .deleteTask: return NSLocalizedString("Remover", comment: "")
        case .loginError: return "Ok"
        case .archiveTask: return NSLocalizedString("Arquivar", comment: "")
        case .deleteWorkspaceMember: return NSLocalizedString("Excluir", comment: "")
        case .deleteTaskKanban: return NSLocalizedString("Remover", comment: "")
        case .archiveTaskKanban: return NSLocalizedString("Arquivar", comment: "")
        }
    }
    
    var width: CGFloat {
        switch self {
        case .deleteAccount: return 378
        case .newWorkspace: return 328
        case .deleteWorkspace: return 328
        case .deleteWorkspaceFromInfo: return 328
        case .joinCode: return 328
        case .shareCode: return 328
        case .documentNotFound: return 328
        case .deleteTask: return 328
        case .loginError: return 328
        case .archiveTask: return 328
        case .deleteWorkspaceMember: return 328
        case .deleteTaskKanban: return 328
        case .archiveTaskKanban: return 328
        }
    }
    
    var height: CGFloat {
        switch self {
        case .deleteAccount: return 364
        case .newWorkspace: return 264
        case .deleteWorkspace: return 264
        case .deleteWorkspaceFromInfo: return 264
        case .joinCode: return 264
        case .shareCode: return 264
        case .documentNotFound: return 264
        case .deleteTask: return 264
        case .loginError: return 264
        case .archiveTask: return 264
        case .deleteWorkspaceMember: return 264
        case .archiveTaskKanban: return 264
        case .deleteTaskKanban: return 264
        }
    }
    
    
}

