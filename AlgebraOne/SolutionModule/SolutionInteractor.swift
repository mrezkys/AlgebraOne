//
//  SolutionInteractor.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class SolutionInteractor: SolutionInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: SolutionInteractorOutputProtocol?
    private var equation: EquationModel?
    
    // MARK: - Initialization
    init(equation: EquationModel) {
        self.equation = equation
    }
    
    // MARK: - SolutionInteractorProtocol
    func fetchData() {
        presenter?.didFetchData()
    }
    
    // MARK: - Custom Methods
    func getEquation() -> EquationModel? {
        return equation
    }
    
    func getSteps() -> [String] {
        return equation?.steps ?? []
    }
} 