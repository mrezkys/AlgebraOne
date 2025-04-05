//
//  TutorialSection.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 05/04/25.
//

import Foundation

enum TutorialSection: Int, CaseIterable {
    case introduction
    case coreConceptsBasics
    case simpleEquations
    case twoSidedEquations
    case distributiveEquations
    case fractionEquations
    case summary
    
    var title: String {
        switch self {
        case .introduction:
            return "Introduction"
        case .coreConceptsBasics:
            return "Basic Concepts"
        case .simpleEquations:
            return "Simple Equations"
        case .twoSidedEquations:
            return "Two-sided Equations"
        case .distributiveEquations:
            return "Distributive Equations"
        case .fractionEquations:
            return "Fraction Equations"
        case .summary:
            return "Summary"
        }
    }
}
