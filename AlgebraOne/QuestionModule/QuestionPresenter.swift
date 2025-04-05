//
//  QuestionPresenter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class QuestionPresenter: QuestionPresenterProtocol {
    // MARK: - Static Properties
    static let questionsPerSession = 8
    
    // MARK: - Properties
    weak var view: QuestionViewProtocol?
    var interactor: QuestionInteractorProtocol?
    var router: QuestionRouterProtocol?
    
    // Current equation model
    private var currentEquation: EquationModel?
    private var answerOptions: [Double] = []
    private var currentQuestionIndex: Int = 0
    private var hasAnsweredCurrentQuestion = false
    
    // Question history
    private var questionsHistory: [QuestionHistory] = []
    
    var isReviewMode: Bool = false
    
    // MARK: - Initialization
    init(view: QuestionViewProtocol) {
        self.view = view
    }
    
    init(view: QuestionViewProtocol, isReviewMode: Bool, questionHistory: QuestionHistory) {
        self.view = view
        self.isReviewMode = isReviewMode
        self.questionsHistory = [questionHistory]
    }
    
    // MARK: - QuestionPresenterProtocol
    func viewDidLoad() {
        if !isReviewMode {
            view?.configureInitialState(questionsCount: QuestionPresenter.questionsPerSession)
            interactor?.fetchData()
        } else {
            view?.configureInitialState(questionsCount: 1)
            guard let question = questionsHistory.first else { return }
            currentEquation = question.equation
            answerOptions = question.answers
            
            let isCorrect = abs(question.userAnswer - question.equation.correctAnswer) < 0.001
            if let answerBoxIndex = question.answers.firstIndex(where: { $0 == question.userAnswer }) {
                DispatchQueue.main.async{
                    self.view?.updateUIForAnswer(isCorrect: isCorrect, at: answerBoxIndex)
                }
            }
            view?.setHelpButtonVisible(true)
            
            view?.updateView()
        }
    }
    
    func getEquationText() -> String {
        return currentEquation?.question ?? "Loading equation..."
    }
    
    func getAnswerOptions() -> [Double] {
        return answerOptions
    }
    
    func getCurrentQuestionIndex() -> Int {
        return currentQuestionIndex
    }
    
    func getQuestionHistory() -> [QuestionHistory] {
        return questionsHistory
    }
    
    func handleBackButtonTapped() {
        if !isReviewMode {
            view?.showEndSessionConfirmation { [weak self] shouldEnd in
                if shouldEnd {
                    self?.router?.navigateBack(from: self?.view)
                }
            }
        } else {
            router?.navigateBack(from: view)
        }
    }
    
    func checkAnswer(at index: Int) -> Bool {
        guard let equation = currentEquation, index < answerOptions.count, !hasAnsweredCurrentQuestion else { return false }
        
        let selectedAnswer = answerOptions[index]
        let correctAnswer = equation.correctAnswer
        
        // Check if the answer is correct (allowing for floating point errors)
        let isCorrect = abs(selectedAnswer - correctAnswer) < 0.001
        
        // Store this question and answer in history
        let historyItem = QuestionHistory(
            equation: equation,
            answers: answerOptions,
            userAnswer: selectedAnswer,
            isCorrect: isCorrect
        )
        questionsHistory.append(historyItem)
        
        // Mark question as answered
        hasAnsweredCurrentQuestion = true
        
        // Update UI state based on answer
        view?.updateUIForAnswer(isCorrect: isCorrect, at: index)
        
        // Enable next button for both correct and incorrect answers
        view?.setNextButtonEnabled(true)
        
        // Show help button only for incorrect answers
        view?.setHelpButtonVisible(true)
        
        // Update progress indicator
        view?.updateProgressIndicator(at: currentQuestionIndex, isCorrect: isCorrect)
        
        return isCorrect
    }
    
    func showHelp() {
        if let equation = currentEquation {
            router?.navigateToSolution(from: view, with: equation)
        }
    }
    
    func goToNextQuestion() {
        // Increment question index
        currentQuestionIndex += 1
        
        if currentQuestionIndex >= QuestionPresenter.questionsPerSession {
            // If we've answered all questions, go to summary
            router?.navigateToSummary(from: view, with: questionsHistory)
        } else {
            // Reset state for new question
            view?.setNextButtonEnabled(false)
            hasAnsweredCurrentQuestion = false
            // Fetch next question
            interactor?.fetchData()
        }
    }
}

extension QuestionPresenter: QuestionInteractorOutputProtocol {
    // MARK: - QuestionInteractorOutputProtocol
    func didFetchEquation(_ equation: EquationModel) {
        // Store the equation and generate answer options
        currentEquation = equation
        answerOptions = equation.generateOptions()
        
        // Update the view
        view?.resetUIForNewQuestion()
        view?.updateView()
    }
}
