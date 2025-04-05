//
//  QuestionProtocols.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

// MARK: - Question View Protocol
protocol QuestionViewProtocol: ViewProtocol {
    var presenter: QuestionPresenterProtocol? { get set }
    
    // Initial setup
    func configureInitialState(questionsCount: Int)
    
    // UI Updates
    func updateView()
    func resetUIForNewQuestion()
    func updateUIForAnswer(isCorrect: Bool, at index: Int)
    
    // Navigation state
    func setNextButtonEnabled(_ enabled: Bool)
    func setHelpButtonVisible(_ visible: Bool)
    
    // Progress tracking
    func updateProgressIndicator(at index: Int, isCorrect: Bool)
    
    // Alerts
    func showEndSessionConfirmation(completion: @escaping (Bool) -> Void)
}

// MARK: - Question Presenter Protocol
protocol QuestionPresenterProtocol: PresenterProtocol {
    var view: QuestionViewProtocol? { get set }
    var interactor: QuestionInteractorProtocol? { get set }
    var router: QuestionRouterProtocol? { get set }
    
    func viewDidLoad()
    
    // Data access
    func getEquationText() -> String
    func getAnswerOptions() -> [Double]
    func getCurrentQuestionIndex() -> Int
    func getQuestionHistory() -> [QuestionHistory]
    
    // User interactions
    func handleBackButtonTapped()
    func checkAnswer(at index: Int) -> Bool
    func showHelp()
    func goToNextQuestion()
    
    // Interactor communication
    func didFetchEquation(_ equation: EquationModel)
}

// MARK: - Question Interactor Protocol
protocol QuestionInteractorProtocol: InteractorProtocol {
    var presenter: QuestionInteractorOutputProtocol? { get set }
    
    func fetchData()
}

// MARK: - Question Interactor Output Protocol
protocol QuestionInteractorOutputProtocol: InteractorOutputProtocol {
    func didFetchEquation(_ equation: EquationModel)
}

// MARK: - Question Router Protocol
protocol QuestionRouterProtocol: RouterProtocol {
    func navigateToModule(from view: ViewProtocol?, to module: UIViewController)
    func navigateBack(from view: ViewProtocol?)
    func navigateToNextQuestion(from view: ViewProtocol?)
    func navigateToSolution(from view: ViewProtocol?, with equation: EquationModel)
    func navigateToSummary(from view: ViewProtocol?, with history: [QuestionHistory])
} 
