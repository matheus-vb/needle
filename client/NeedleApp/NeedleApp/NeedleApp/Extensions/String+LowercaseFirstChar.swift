//
//  String+LowercaseFirstChar.swift
//  NeedleApp
//
//  Created by matheusvb on 10/08/23.
//

import Foundation

extension String {
    func firstCharacterLowercased() -> String {
        guard let firstChar = self.first else { return self }
        return firstChar.lowercased() + dropFirst()
    }
}
