//
//  StepType.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 05/04/25.
//

import Foundation

enum StepType {
    case header
    case equation
    case explanation
    case verification
    case spacer
    
    var isHighlighted: Bool {
        switch self {
        case .header, .equation, .verification:
            return true
        case .explanation, .spacer:
            return false
        }
    }
}
