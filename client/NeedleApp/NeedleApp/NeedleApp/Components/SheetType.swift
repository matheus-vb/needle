//
//  SheetType.swift
//  NeedleApp
//
//  Created by Bof on 09/08/23.
//

import Foundation
import SwiftUI

enum SheetType {
    case newWorkspace, deleteWorkspace, joinCode, shareCode, documentNotFound, deleteTask
    
    var image: Image {
        switch self {
        case .newWorkspace: return Image("NewWorkspace")
        case .deleteWorkspace: return Image("DeleteWorkspace")
        case .joinCode: return Image("JoinCode")
        case .shareCode: return Image("ShareCode")
        case .documentNotFound: return Image("DocumentNotFound")
        case .deleteTask: return Image("CleanTask")
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
        }
    }
    
    var text: String {
        switch self {
        case .newWorkspace: return "Nomeie seu novo workspace:"
        case .deleteWorkspace: return "Lembre-se, ao excluir um workspace,\nsuas tasks e documentos serão perdidos"
        case .joinCode: return "Insira o código do workspace:"
        case .shareCode: return "Envie o código do workspace para sua equipe e deixe-a alinhada"
        case .documentNotFound: return "Procure por outras palavras-chave como título da task, área ou data"
        case .deleteTask: return "Não se preocupe, a documentação da task\nirá permanecer na aba de documentos"

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

        }
    }
    
    
}

