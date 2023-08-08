//
//  Document.swift
//  Needle
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation

struct Document: Codable, Identifiable{
    let id: String
    let title: String
    let text: String
    let author: String?
    let type: String
    let textString: String
}
