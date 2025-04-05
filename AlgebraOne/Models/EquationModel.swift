//
//  EquationModel.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

struct EquationModel {
    let question: String
    let correctAnswer: Double
    let steps: [String]
    
    // For generating multiple-choice options
    func generateOptions() -> [Double] {
        let correctAnswer = self.correctAnswer
        var options = [correctAnswer]
        
        // Generate 3 additional wrong options
        while options.count < 4 {
            // Create variations that are whole numbers between -30 and 30
            let wrongOption = Double(Int.random(in: -30...30))
            
            // Ensure no duplicates and not equal to correct answer
            if !options.contains(wrongOption) && abs(wrongOption - correctAnswer) > 0.1 {
                options.append(wrongOption)
            }
        }
        
        return options.shuffled()
    }
} 
