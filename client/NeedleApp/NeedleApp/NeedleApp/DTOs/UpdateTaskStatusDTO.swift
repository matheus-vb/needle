//
//  UpdateTaskStatusDTO.swift
//  NeedleApp
//
//  Created by matheusvb on 04/08/23.
//

import Foundation

struct UpdateTaskStatusDTO: Codable {
    let taskId: String
    let status: String
}
