//
//  Coordinator.swift
//  Needle
//
//  Created by jpcm2 on 01/06/23.
//

import SwiftUI

enum Page: String, Identifiable{
    case login, register
    
    var id: String {
        self.rawValue
    }
}
