//
//  OnboardingRouter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 08/04/25.
//


import UIKit

class OnboardingRouter: OnboardingRouterProtocol {
    weak var view: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = OnboardingViewController()
        let interactor = OnboardingInteractor()
        let router = OnboardingRouter()
        let presenter = OnboardingPresenter(view: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
    func navigateToWelcome() {
        let welcomeVC = WelcomeRouter.createModule()

        if let navigationController = view?.navigationController {
            let viewControllers = [ welcomeVC]
            navigationController.setViewControllers(viewControllers, animated: true)
        }
    }
} 
