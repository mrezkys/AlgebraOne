//
//  Array.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 05/04/25.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
