//
//  SolutionPresenter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class SolutionPresenter: SolutionPresenterProtocol {
    
    // MARK: - Properties
    weak var view: SolutionViewProtocol?
    var interactor: SolutionInteractorProtocol?
    var router: SolutionRouterProtocol?
    
    // MARK: - Initialization
    init(view: SolutionViewProtocol) {
        self.view = view
    }
    
    // MARK: - SolutionPresenterProtocol
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func getEquationText() -> String {
        if let interactor = interactor {
            return interactor.getEquation()?.question ?? "Equation not found"
        }
        return "Equation not found"
    }
    
    func getStepsCount() -> Int {
        if let interactor = interactor {
            return interactor.getSteps().count
        }
        return 0
    }
    
    func getStep(at index: Int) -> String {
        if let interactor = interactor {
            let steps = interactor.getSteps()
            guard index < steps.count else { return "" }
            return steps[index]
        }
        return ""
    }
    
    func continueLearning() {
        router?.navigateBack(from: view)
    }
    

}

extension SolutionPresenter: SolutionInteractorOutputProtocol {
    // MARK: - SolutionInteractorOutputProtocol
    func didFetchData() {
        view?.updateView()
    }
}
