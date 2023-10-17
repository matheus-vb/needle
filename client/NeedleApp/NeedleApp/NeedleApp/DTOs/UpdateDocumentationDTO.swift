//
//  UpdateDocumentationDTO.swift
//  NeedleApp
//
//  Created by jpcm2 on 31/07/23.
//

import Foundation

struct UpdateDocumentationDTO: Codable{
    var id: String
    var text: String //Aqui vai o data rtf
    var textString: String //Aqui vai o texto string mesmo
}
