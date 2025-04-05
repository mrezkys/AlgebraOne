//
//  SolutionRouter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

class SolutionRouter: SolutionRouterProtocol {
    
    // MARK: - RouterProtocol
    static func createModule() -> UIViewController {
        fatalError("Use createModule(with:) instead")
    }
    
    static func createModule(with equation: EquationModel) -> UIViewController {
        let view = SolutionViewController()
        let presenter = SolutionPresenter(view: view)
        let interactor = SolutionInteractor(equation: equation)
        let router = SolutionRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    // MARK: - SolutionRouterProtocol
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
} 
