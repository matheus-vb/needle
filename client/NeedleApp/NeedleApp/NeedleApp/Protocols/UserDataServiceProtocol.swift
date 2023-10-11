//
//  UserServiceProtocol.swift
//  NeedleApp
//
//  Created by vivi on 05/10/23.
//

import Foundation

protocol UserDataServiceProtocol: ObservableObject {
    
    var currError: NetworkingManager.NetworkingError? { get set }
    
    var errorCount: Int { get set }
    var errorCountPublisher: Published<Int>.Publisher { get }
    
    func deleteUser(userId: String)
}
