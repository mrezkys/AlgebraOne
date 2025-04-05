//
//  LinearEquationPattern.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

enum LinearEquationPattern: CaseIterable {
    case axPlusB_EqualsC          // ax + b = c
    case axPlusB_EqualsDxPlusE    // ax + b = dx + e
    case aTimesBPlusX_EqualsC     // a(x + b) = c
    case xPlusB_DividedByA_EqualsC // (x + b)/a = c
    
    func generate() -> EquationModel {
        switch self {
        case .axPlusB_EqualsC:
            return generateAxPlusBEqualsC()
        case .axPlusB_EqualsDxPlusE:
            return generateAxPlusBEqualsDxPlusE()
        case .aTimesBPlusX_EqualsC:
            return generateATimesBPlusXEqualsC()
        case .xPlusB_DividedByA_EqualsC:
            return generateXPlusBDividedByAEqualsC()
        }
    }
    
    // Generate equation of form ax + b = c
    private func generateAxPlusBEqualsC() -> EquationModel {
        // Generate coefficients with simple, clean answers
        let a = Double(Int.random(in: 1...10))
        let x = Double(Int.random(in: -10...10))
        let b = Double(Int.random(in: -20...20))
        let c = a * x + b
        
        // Format the equation
        let question = "\(Int(a))x + \(Int(b)) = \(Int(c))"
        
        // Generate solving steps
        var steps: [String] = []
        steps.append("Step 1: Subtract \(Int(b)) from both sides → \(Int(a))x = \(Int(c-b))")
        steps.append("Step 2: Divide both sides by \(Int(a)) → x = \(x)")
        steps.append("Final Step: The value of x is \(x)")
        
        return EquationModel(question: question, correctAnswer: x, steps: steps)
    }
    
    // Generate equation of form ax + b = dx + e
    private func generateAxPlusBEqualsDxPlusE() -> EquationModel {
        // Generate coefficients with simple, clean answers
        let a = Double(Int.random(in: 2...10))
        let d = Double(Int.random(in: 1...Int(a-1))) // Ensure a > d for simplicity
        let x = Double(Int.random(in: -10...10))
        let b = Double(Int.random(in: -20...20))
        let e = (a - d) * x + b
        
        // Format the equation
        let question = "\(Int(a))x + \(Int(b)) = \(Int(d))x + \(Int(e))"
        
        // Generate solving steps
        var steps: [String] = []
        steps.append("Step 1: Subtract \(Int(d))x from both sides → \(Int(a-d))x + \(Int(b)) = \(Int(e))")
        steps.append("Step 2: Subtract \(Int(b)) from both sides → \(Int(a-d))x = \(Int(e-b))")
        steps.append("Step 3: Divide both sides by \(Int(a-d)) → x = \(x)")
        steps.append("Final Step: The value of x is \(x)")
        
        return EquationModel(question: question, correctAnswer: x, steps: steps)
    }
    
    // Generate equation of form a(x + b) = c
    private func generateATimesBPlusXEqualsC() -> EquationModel {
        // Generate coefficients with simple, clean answers
        let a = Double(Int.random(in: 2...10))
        let b = Double(Int.random(in: -10...10))
        let x = Double(Int.random(in: -10...10))
        let c = a * (x + b)
        
        // Format the equation
        let question = "\(Int(a))(x + \(Int(b))) = \(Int(c))"
        
        // Generate solving steps
        var steps: [String] = []
        steps.append("Step 1: Divide both sides by \(Int(a)) → (x + \(Int(b))) = \(c/a)")
        steps.append("Step 2: Subtract \(Int(b)) from both sides → x = \(x)")
        steps.append("Final Step: The value of x is \(x)")
        
        return EquationModel(question: question, correctAnswer: x, steps: steps)
    }
    
    // Generate equation of form (x + b)/a = c
    private func generateXPlusBDividedByAEqualsC() -> EquationModel {
        // Generate coefficients with simple, clean answers
        let a = Double(Int.random(in: 2...10))
        let b = Double(Int.random(in: -10...10))
        let x = Double(Int.random(in: -10...10))
        let c = (x + b) / a
        
        // Format the equation
        let question = "(x + \(Int(b))) / \(Int(a)) = \(c)"
        
        // Generate solving steps
        var steps: [String] = []
        steps.append("Step 1: Multiply both sides by \(Int(a)) → (x + \(Int(b))) = \(c*a)")
        steps.append("Step 2: Subtract \(Int(b)) from both sides → x = \(x)")
        steps.append("Final Step: The value of x is \(x)")
        
        return EquationModel(question: question, correctAnswer: x, steps: steps)
    }
} 