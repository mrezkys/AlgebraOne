//
//  SummaryInteractor.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class SummaryInteractor: SummaryInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: SummaryInteractorOutputProtocol?
    var questionsHistory: [QuestionHistory]
    
    // MARK: - Initialization
    init(questionsHistory: [QuestionHistory] = []) {
        self.questionsHistory = questionsHistory
    }
    
    // MARK: - SummaryInteractorProtocol
    func fetchData() {
        presenter?.didSuccessFetchData()
    }
    
    // MARK: - Custom Methods
    func getQuestionsAnswered() -> Int {
        return questionsHistory.filter { $0.isCorrect }.count
    }
    
    func getQuestionsHistory() -> [QuestionHistory] {
        return questionsHistory
    }
}
