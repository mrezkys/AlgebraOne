//
//  TutorialProtocols.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

// MARK: - Tutorial View Protocol
protocol TutorialViewProtocol: ViewProtocol {
    var presenter: TutorialPresenterProtocol? { get set }
    
    // Initial setup
    func configureInitialState()
    
    // UI Updates
    func showSection(_ section: TutorialSection)
    func displayStep(title: String, description: String, equation: String?)
    func displaySteps(_ steps: [StepModel])
    func configureNavigation(isPreviousEnabled: Bool, isLastStep: Bool)
}

// MARK: - Tutorial Presenter Protocol
protocol TutorialPresenterProtocol: PresenterProtocol {
    var view: TutorialViewProtocol? { get set }
    var interactor: TutorialInteractorProtocol? { get set }
    var router: TutorialRouterProtocol? { get set }
    
    func viewDidLoad()
    
    // Navigation
    func navigateToNextStep()
    func navigateToPreviousStep()
    func completeSection()
    func skipToMainMenu()
    
    // Data
    func getCurrentSection() -> TutorialSection
    func getCurrentStepIndex() -> Int
    func getTotalStepsCount() -> Int
    func getCurrentStep() -> TutorialStep
}

// MARK: - Tutorial Interactor Protocol
protocol TutorialInteractorProtocol: InteractorProtocol {
    var presenter: TutorialInteractorOutputProtocol? { get set }
    
    func getCurrentSection() -> TutorialSection
    func setCurrentSection(_ section: TutorialSection)
    func getCurrentStepIndex() -> Int
    func setCurrentStepIndex(_ index: Int)
    func getCurrentStep() -> TutorialStep
    func getTotalStepsCount() -> Int
    func hasNextStep() -> Bool
    func hasPreviousStep() -> Bool
    func moveToNextStep() -> Bool
    func moveToPreviousStep() -> Bool
    func isLastSectionAndStep() -> Bool
}

// MARK: - Tutorial Interactor Output Protocol
protocol TutorialInteractorOutputProtocol: InteractorOutputProtocol {
    func didUpdateCurrentStep()
    func didUpdateSection()
    func didReachEndOfTutorial()
    func navigateToWelcome()
}

// MARK: - Tutorial Router Protocol
protocol TutorialRouterProtocol: RouterProtocol {
    func navigateToMainMenu(from view: ViewProtocol?)
    func navigateToNextSection(from view: ViewProtocol?)
    func navigateToQuestions(from view: ViewProtocol?)
} 
