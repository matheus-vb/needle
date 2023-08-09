//
//  SheetType.swift
//  NeedleApp
//
//  Created by Bof on 09/08/23.
//

import Foundation
import SwiftUI

enum SheetType {
    case newWorkspace, deleteWorkspace, joinCode, shareCode, documentNotFound, deleteTask, loginError
    
    var image: Image {
        switch self {
        case .newWorkspace: return Image("NewWorkspace")
        case .deleteWorkspace: return Image("DeleteWorkspace")
        case .joinCode: return Image("JoinCode")
        case .shareCode: return Image("ShareCode")
        case .documentNotFound: return Image("DocumentNotFound")
        case .deleteTask: return Image("CleanTask")
        case .loginError: return Image("LoginError")
        }
    }
    
    var title: String {
        switch self {
        case .newWorkspace: return ""
        case .deleteWorkspace:return "Excluir projeto?"
        case .joinCode: return ""
        case .shareCode: return ""
        case .documentNotFound: return "Documento não encontrado"
        case .deleteTask: return "Remover task do kanban?"
        case .loginError: return "Erro de login"
        }
    }
    
    var text: String {
        switch self {
        case .newWorkspace: return "Nomeie seu novo workspace:"
        case .deleteWorkspace: return "Lembre-se, ao excluir um workspace,\nsuas tasks e documentos serão perdidos."
        case .joinCode: return ""
        case .shareCode: return "Envie o código do workspace para sua equipe e deixe-a alinhada."
        case .documentNotFound: return "Procure por outras palavras-chave como título da task, área ou data!"
        case .deleteTask: return "Não se preocupe, a documentação da task irá permanecer na aba de documentos."
        case .loginError: return "Confira o ID registrado ou tente novamente."

        }
    }
    
    var twoButtons: Bool {
        switch self {
        case .newWorkspace: return true
        case .deleteWorkspace: return true
        case .joinCode: return true
        case .shareCode: return true
        case .documentNotFound: return false
        case .deleteTask: return true
        case .loginError: return false

        }
    }
    
    var primaryAction: String {
        switch self {
        case .newWorkspace: return "Criar"
        case .deleteWorkspace: return "Excluir"
        case .joinCode: return "Entrar"
        case .shareCode: return "Copiar"
        case .documentNotFound: return "Ok"
        case .deleteTask: return "Remover"
        case .loginError: return "Ok"

        }
    }
    
    var width: CGFloat {
        switch self {
        case .newWorkspace: return 328
        case .deleteWorkspace: return 328
        case .joinCode: return 328
        case .shareCode: return 328
        case .documentNotFound: return 328
        case .deleteTask: return 328
        case .loginError: return 328


        }
    }
    
    var height: CGFloat {
        switch self {
        case .newWorkspace: return 264
        case .deleteWorkspace: return 264
        case .joinCode: return 264
        case .shareCode: return 264
        case .documentNotFound: return 264
        case .deleteTask: return 264
        case .loginError: return 264


        }
    }
    
    
}

