//
//  ConvertToDict.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation

func convertToDictionary<T>(_ obj: T) -> [String: Any] {
    let mirror = Mirror(reflecting: obj)
    var dict = [String: Any]()
    for child in mirror.children {
        guard let label = child.label else { continue }
        if let value = child.value as? OptionalProtocol, let unwrapped = value.optional {
            dict[label] = unwrapped
        } else {
            dict[label] = child.value
        }
    }
    return dict
}

protocol OptionalProtocol {
    var optional: Any? { get }
}

extension Optional: OptionalProtocol {
    var optional: Any? { return self }
}
