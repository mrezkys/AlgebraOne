//
//  QuestionRouter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

class QuestionRouter: QuestionRouterProtocol {
    
    // Counter for questions answered
    private static var questionsAnswered = 0
    
    // MARK: - RouterProtocol
    static func createModule() -> UIViewController {
        let view = QuestionViewController()
        let presenter = QuestionPresenter(view: view)
        let interactor = QuestionInteractor()
        let router = QuestionRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    static func createReviewModule(questionHistory: QuestionHistory) -> UIViewController {
        let view = QuestionViewController()
        let presenter = QuestionPresenter(view: view, isReviewMode: true, questionHistory: questionHistory)
        let interactor = QuestionInteractor()
        let router = QuestionRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    // MARK: - QuestionRouterProtocol
    func navigateToModule(from view: ViewProtocol?, to module: UIViewController) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(module, animated: true)
        }
    }
    
    func navigateBack(from view: ViewProtocol?) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popViewController(animated: true)
        }
    }
    
    func navigateToNextQuestion(from view: ViewProtocol?) {
        // Increment questions answered
        QuestionRouter.questionsAnswered += 1
        
        // Check if we've reached the end of the session
        if QuestionRouter.questionsAnswered >= QuestionPresenter.questionsPerSession {
            // Navigate to summary with empty history
            navigateToSummary(from: view, with: [])
        } else {
            // Create a new question module
            if let sourceView = view as? UIViewController {
                // Create a new instance
                let questionModule = QuestionRouter.createModule()

                // Replace the current view controller with the new one
                sourceView.navigationController?.setViewControllers(
                    [sourceView.navigationController!.viewControllers.first!, questionModule], 
                    animated: true
                )
            }
        }
    }

    func navigateToSolution(from view: ViewProtocol?, with equation: EquationModel) {
        let solutionModule = SolutionRouter.createModule(with: equation)
        navigateToModule(from: view, to: solutionModule)
    }

    func navigateToSummary(from view: ViewProtocol?, with history: [QuestionHistory]) {
        let summaryModule = SummaryRouter.createModule(questionsHistory: history)

        // Replace the navigation stack to prevent going back to questions
        if let sourceView = view as? UIViewController, let navigationController = sourceView.navigationController {
            let viewControllers = [navigationController.viewControllers.first!, summaryModule]
            navigationController.setViewControllers(viewControllers, animated: true)
        }
    }
} 
