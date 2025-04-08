//
//  OnboardingProtocols.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 08/04/25.
//

import UIKit

// MARK: - View
protocol OnboardingViewProtocol: AnyObject {
    var presenter: OnboardingPresenterProtocol? { get set }
    
    // View Methods
    func setupUI()
}

// MARK: - Presenter
protocol OnboardingPresenterProtocol: AnyObject {
    var view: OnboardingViewProtocol? { get set }
    var interactor: OnboardingInteractorProtocol? { get set }
    var router: OnboardingRouterProtocol? { get set }
    
    // View -> Presenter
    func viewDidLoad()
    func didTapReadyButton()
}

// MARK: - Interactor
protocol OnboardingInteractorProtocol: AnyObject {
    var presenter: OnboardingPresenterProtocol? { get set }
    
    // Presenter -> Interactor
}

// MARK: - Router
protocol OnboardingRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    
    // Presenter -> Router
    static func createModule() -> UIViewController
    func navigateToWelcome()
} 
