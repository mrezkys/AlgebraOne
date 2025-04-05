//
//  TutorialRouter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

class TutorialRouter: TutorialRouterProtocol {
    
    // MARK: - RouterProtocol
    static func createModule() -> UIViewController {
        let view = TutorialViewController()
        let presenter = TutorialPresenter(view: view)
        let interactor = TutorialInteractor()
        let router = TutorialRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    // MARK: - TutorialRouterProtocol
    func navigateToMainMenu(from view: ViewProtocol?) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func navigateToNextSection(from view: ViewProtocol?) {
        if let sourceView = view as? UIViewController {
            // Create a new instance of the Tutorial module with the next section
            let tutorialModule = TutorialRouter.createModule()
            // Replace the current view controller with the new one
            sourceView.navigationController?.pushViewController(tutorialModule, animated: true)
        }
    }
    
    func navigateToQuestions(from view: ViewProtocol?) {
        if let sourceView = view as? UIViewController {
            // Create and navigate to the Question module
            let questionModule = QuestionRouter.createModule()
            
            // Reset navigation stack to have just the root and the question module
            if let navigationController = sourceView.navigationController,
               let rootViewController = navigationController.viewControllers.first {
                navigationController.setViewControllers([rootViewController, questionModule], animated: true)
            } else {
                // Fallback if we can't get the navigation controller or root
                sourceView.navigationController?.popToRootViewController(animated: false)
                if let rootVC = sourceView.navigationController?.topViewController {
                    rootVC.navigationController?.pushViewController(questionModule, animated: true)
                }
            }
        }
    }
} 
