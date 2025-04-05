//
//  QuestionInteractor.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class QuestionInteractor: QuestionInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: QuestionInteractorOutputProtocol?
    var equation: EquationModel? // For preview purposes
    
    // MARK: - Initialization
    init() {
    }
    
    // MARK: - QuestionInteractorProtocol
    func fetchData() {
        if let predefinedEquation = equation {
            // Use the predefined equation (for preview)
            presenter?.didFetchEquation(predefinedEquation)
        } else {
            // Generate a new random equation
            let equation = EquationGenerator.generateRandomEquation()

            // Notify the presenter
            presenter?.didFetchEquation(equation)
        }
    }
} 
