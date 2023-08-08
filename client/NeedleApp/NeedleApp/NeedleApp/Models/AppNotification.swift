//
//  AppNotification.swift
//  NeedleApp
//
//  Created by Bof on 02/08/23.
//

import Foundation

enum NotificationType {
    case rejected, accepted, changed
    
    var action : String {
        switch self {
        case .rejected: return " rejeitou sua documentação de "
        case .accepted: return " aceitou sua documentação de "
        case .changed: return " alterou o status de "
        }
    }
}

struct AppNotification {
    var username: String
    var type: NotificationType
    var task: String
    var projectName: String
    var timeAgo: String
}
