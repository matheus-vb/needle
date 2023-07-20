//
//  DocumentModel.swift
//  Needle
//
//  Created by matheusvb on 30/05/23.
//

import Foundation

struct SingleDocumentResponse: Codable {
    let data: Document
}

struct DocumentResponse: Codable {
    let data: [Document]
}

struct Document: Codable, Identifiable {
    let id: String
    let title: String
    let text: String
    //let author: String?
    let type: String
}
