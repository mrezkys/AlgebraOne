//
//  SummaryProtocols.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

// MARK: - Summary View Protocol
protocol SummaryViewProtocol: ViewProtocol {
    var presenter: SummaryPresenterProtocol? { get set }
    
    func updateView()
}

// MARK: - Summary Presenter Protocol
protocol SummaryPresenterProtocol: PresenterProtocol {
    var view: SummaryViewProtocol? { get set }
    var interactor: SummaryInteractorProtocol? { get set }
    var router: SummaryRouterProtocol? { get set }
    
    func viewDidLoad()
    
    // Methods for view to get data
    func getQuestionsAnsweredTrue() -> Int
    func getEncouragingMessage() -> String
    
    // Method for handling user interactions
    func startNewSession()
    func reviewQuestion(questionHistory: QuestionHistory)
    
    // Method that will be called by Interactor after data is fetched
    func getQuestionsHistory() -> [QuestionHistory]
}

// MARK: - Summary Interactor Protocol
protocol SummaryInteractorProtocol: InteractorProtocol {
    var presenter: SummaryInteractorOutputProtocol? { get set }
    
    // Method that will be called by Presenter to fetch data
    func fetchData()
    
    // Method to get questions answered
    func getQuestionsAnswered() -> Int
    func getQuestionsHistory() -> [QuestionHistory]
}

// MARK: - Summary Interactor Output Protocol
protocol SummaryInteractorOutputProtocol: InteractorOutputProtocol {
    func didSuccessFetchData()
}

// MARK: - Summary Router Protocol
protocol SummaryRouterProtocol: RouterProtocol {
    // Methods for navigation
    func navigateToModule(from view: ViewProtocol?, to module: UIViewController)
    func navigateToWelcome(from view: ViewProtocol?)
    
    // Static method to create module with questions answered
    static func createModule(questionsHistory: [QuestionHistory]) -> UIViewController
    func navigateToQuestionReview(from view: ViewProtocol?, with questionHistory: QuestionHistory)
}
