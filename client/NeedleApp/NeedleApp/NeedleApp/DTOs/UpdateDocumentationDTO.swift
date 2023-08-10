//
//  UpdateDocumentationDTO.swift
//  NeedleApp
//
//  Created by jpcm2 on 31/07/23.
//

import Foundation

struct UpdateDocumentationDTO: Codable{
    let id: String
    let text: String //Aqui vai o data rtf
    let textString: String //Aqui vai o texto string mesmo
}
