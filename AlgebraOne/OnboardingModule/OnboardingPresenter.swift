//
//  OnboardingPresenter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 08/04/25.
//

import Foundation

class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    var interactor: OnboardingInteractorProtocol?
    var router: OnboardingRouterProtocol?
    
    init(view: OnboardingViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setupUI()
    }
    
    func didTapReadyButton() {
        router?.navigateToWelcome()
    }
} 
