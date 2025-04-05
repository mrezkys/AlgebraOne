//
//  SummaryPresenter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class SummaryPresenter: SummaryPresenterProtocol  {
    
    // MARK: - Properties
    weak var view: SummaryViewProtocol?
    var interactor: SummaryInteractorProtocol?
    var router: SummaryRouterProtocol?
    
    // MARK: - Initialization
    init(view: SummaryViewProtocol) {
        self.view = view
    }
    
    // MARK: - SummaryPresenterProtocol
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func getQuestionsAnsweredTrue() -> Int {
        if let interactor = interactor {
            return interactor.getQuestionsAnswered()
        }
        return 0
    }
    
    func getQuestionsHistory() -> [QuestionHistory] {
        if let interactor = interactor {
            return interactor.getQuestionsHistory()
        }
        return []
    }
    
    func getEncouragingMessage() -> String {
        let questionsAnswered = getQuestionsAnsweredTrue()
        
        switch questionsAnswered {
        case 1:
            return "You've taken your first step toward mastering algebra! Keep going!"
        case 2...3:
            return "You're making good progress! Keep practicing to improve!"
        case 4:
            return "Impressive work! You're getting very good at this!"
        default:
            return "Outstanding! You're on your way to becoming an algebra master!"
        }
    }
    
    func startNewSession() {
        router?.navigateToWelcome(from: view)
    }
    
    func reviewQuestion(questionHistory: QuestionHistory) {
        router?.navigateToQuestionReview(from: view, with: questionHistory)
    }
}

extension SummaryPresenter: SummaryInteractorOutputProtocol {
    func didSuccessFetchData() {
        view?.updateView()
    }
}
