//
//  SolutionProtocols.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

// MARK: - Solution View Protocol
protocol SolutionViewProtocol: ViewProtocol {
    var presenter: SolutionPresenterProtocol? { get set }
    
    func updateView()
}

// MARK: - Solution Presenter Protocol
protocol SolutionPresenterProtocol: PresenterProtocol {
    var view: SolutionViewProtocol? { get set }
    var interactor: SolutionInteractorProtocol? { get set }
    var router: SolutionRouterProtocol? { get set }

    func viewDidLoad()

    // Methods for view to get data
    func getEquationText() -> String
    func getStepsCount() -> Int
    func getStep(at index: Int) -> String

    // Method for handling user interactions
    func continueLearning()

    // Method that will be called by Interactor after data is fetched
    func didFetchData()
}

// MARK: - Solution Interactor Protocol
protocol SolutionInteractorProtocol: InteractorProtocol {
    var presenter: SolutionInteractorOutputProtocol? { get set }
    
    func fetchData()
    
    func getEquation() -> EquationModel?
    func getSteps() -> [String]
}

// MARK: - Solution Interactor Output Protocol
protocol SolutionInteractorOutputProtocol: InteractorOutputProtocol {
    func didFetchData()
}

// MARK: - Solution Router Protocol
protocol SolutionRouterProtocol: RouterProtocol {
    func navigateToModule(from view: ViewProtocol?, to module: UIViewController)
    func navigateBack(from view: ViewProtocol?)
    
    // Static method to create module with equation
    static func createModule(with equation: EquationModel) -> UIViewController
} 
