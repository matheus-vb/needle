//
//  NotificationService.swift
//  NeedleApp
//
//  Created by matheusvb on 28/07/23.
//

import Foundation

class NotificationService {
    private init(){}
    
    static let shared = NotificationService()
    
    var token: String?
}
