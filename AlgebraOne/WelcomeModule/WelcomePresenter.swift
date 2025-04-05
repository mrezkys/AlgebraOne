//
//  WelcomePresenter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class WelcomePresenter: WelcomePresenterProtocol {
    // MARK: - Properties
    weak var view: WelcomeViewProtocol?
    var interactor: WelcomeInteractorProtocol?
    var router: WelcomeRouterProtocol?
    
    // MARK: - Initialization
    init(view: WelcomeViewProtocol) {
        self.view = view
    }
    
    // MARK: - WelcomePresenterProtocol
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func startLearning() {
        router?.navigateToQuestion(from: view)
    }
    
    func showTutorial() {
        router?.navigateToTutorial(from: view)
    }
    

}

extension WelcomePresenter: WelcomeInteractorOutputProtocol {
    // MARK: - WelcomeInteractorOutputProtocol
    func didSuccessFetchData() {}
}
