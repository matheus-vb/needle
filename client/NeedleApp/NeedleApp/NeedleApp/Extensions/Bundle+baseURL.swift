//
//  Bundle+baseURL.swift
//  NeedleApp
//
//  Created by matheusvb on 31/07/23.
//

import Foundation

extension Bundle {
    static var baseURL: String {
        let urlString = Bundle.main.object(forInfoDictionaryKey: "API_URL") as! String
        return urlString
    }
}
