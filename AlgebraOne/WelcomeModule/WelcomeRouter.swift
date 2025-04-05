//
//  WelcomeRouter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

class WelcomeRouter: WelcomeRouterProtocol {
    
    // MARK: - RouterProtocol
    static func createModule() -> UIViewController {
        let view = WelcomeViewController()
        let presenter = WelcomePresenter(view: view)
        let interactor = WelcomeInteractor()
        let router = WelcomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    // MARK: - WelcomeRouterProtocol
    func navigateToModule(from view: ViewProtocol?, to module: UIViewController) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(module, animated: true)
        }
    }
    
    func navigateToQuestion(from view: ViewProtocol?) {
        let questionModule = QuestionRouter.createModule()
        navigateToModule(from: view, to: questionModule)
    }
    
    func navigateToTutorial(from view: ViewProtocol?) {
        let tutorialModule = TutorialRouter.createModule()
        navigateToModule(from: view, to: tutorialModule)
    }
} 
