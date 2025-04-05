//
//  EquationGenerator.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class EquationGenerator {
    static func generateRandomEquation() -> EquationModel {
        // Randomly select a pattern from the available patterns
        let randomPattern = LinearEquationPattern.allCases.randomElement()!
        
        // Generate an equation using the selected pattern
        return randomPattern.generate()
    }
    
    static func generateSequence(count: Int) -> [EquationModel] {
        var equations: [EquationModel] = []
        
        for _ in 0..<count {
            equations.append(generateRandomEquation())
        }
        
        return equations
    }
} 