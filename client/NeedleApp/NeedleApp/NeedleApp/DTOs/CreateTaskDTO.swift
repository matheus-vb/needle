//
//  CreateTaskDTO.swift
//  NeedleApp
//
//  Created by jpcm2 on 28/07/23.
//

import Foundation

struct CreateTaskDTO: Codable{
    let userId: String
    let accessCode: String
    let title: String
    let description: String
    let stats: String
    let type: String
    let endDate: Date
}
