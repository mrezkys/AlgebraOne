//
//  WelcomeProtocols.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

// MARK: - Welcome View Protocol
protocol WelcomeViewProtocol: ViewProtocol {
    var presenter: WelcomePresenterProtocol? { get set }
}

// MARK: - Welcome Presenter Protocol
protocol WelcomePresenterProtocol: PresenterProtocol {
    var view: WelcomeViewProtocol? { get set }
    var interactor: WelcomeInteractorProtocol? { get set }
    var router: WelcomeRouterProtocol? { get set }
    
    func viewDidLoad()
    
    func startLearning()
    func showTutorial()
}

// MARK: - Welcome Interactor Protocol
protocol WelcomeInteractorProtocol: InteractorProtocol {
    var presenter: WelcomeInteractorOutputProtocol? { get set }
    
    func fetchData()
}

// MARK: - Welcome Interactor Output Protocol
protocol WelcomeInteractorOutputProtocol: InteractorOutputProtocol {
    func didSuccessFetchData()
}

// MARK: - Welcome Router Protocol
protocol WelcomeRouterProtocol: RouterProtocol {
    func navigateToQuestion(from view: ViewProtocol?)
    
    func navigateToTutorial(from view: ViewProtocol?)
    
    func navigateToModule(from view: ViewProtocol?, to module: UIViewController)
} 
