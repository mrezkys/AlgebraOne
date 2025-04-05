//
//  SummaryRouter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

class SummaryRouter: SummaryRouterProtocol {
    
    
    // MARK: - RouterProtocol
    static func createModule() -> UIViewController {
        fatalError("Use createModule(questionsAnswered:) instead")
    }
    
    static func createModule(questionsHistory: [QuestionHistory]) -> UIViewController {
        let view = SummaryViewController()
        let presenter = SummaryPresenter(view: view)
        let interactor = SummaryInteractor(questionsHistory: questionsHistory)
        let router = SummaryRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    // MARK: - SummaryRouterProtocol
    func navigateToModule(from view: ViewProtocol?, to module: UIViewController) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(module, animated: true)
        }
    }
    
    func navigateToWelcome(from view: ViewProtocol?) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func navigateToQuestionReview(from view: ViewProtocol?, with questionHistory: QuestionHistory) {
        let summaryModule = QuestionRouter.createReviewModule(questionHistory: questionHistory)
        
        if let sourceView = view as? UIViewController, let navigationController = sourceView.navigationController {
            navigationController.pushViewController(summaryModule, animated: true)
        }
    }
}
