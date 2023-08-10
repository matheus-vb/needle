//
//  QueryTasksDTO.swift
//  NeedleApp
//
//  Created by matheusvb on 08/08/23.
//

import Foundation

struct QueryTasksDTO: Codable {
    let workspaceId: String
    var query: String?
    var status: String?
    var area: String?
    var priority: String?
    
    func toQueryString() -> String {
        var components = URLComponents()
        
        components.queryItems = [
            query.map { URLQueryItem(name: "query", value: $0) },
            status.map { URLQueryItem(name: "status", value: $0) },
            area.map { URLQueryItem(name: "area", value: $0) },
            priority.map { URLQueryItem(name: "priority", value: $0) }
        ].compactMap { $0 }
        
        return components.url?.query ?? ""
    }
}
