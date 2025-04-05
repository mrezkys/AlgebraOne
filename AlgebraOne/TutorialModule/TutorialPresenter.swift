//
//  TutorialPresenter.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class TutorialPresenter: TutorialPresenterProtocol, TutorialInteractorOutputProtocol {
    
    // MARK: - Properties
    weak var view: TutorialViewProtocol?
    var interactor: TutorialInteractorProtocol?
    var router: TutorialRouterProtocol?
    
    // MARK: - Initialization
    init(view: TutorialViewProtocol) {
        self.view = view
    }
    
    // MARK: - TutorialPresenterProtocol
    func viewDidLoad() {
        view?.configureInitialState()
        
        updateViewWithCurrentSectionAndStep()
    }
    
    func navigateToNextStep() {
        guard let interactor = interactor else { return }
        
        // If we're at the very last step, complete the section
        let currentSection = interactor.getCurrentSection() 
        let isLastSection = currentSection == TutorialSection.allCases.last
        let index = interactor.getCurrentStepIndex()
        let total = interactor.getTotalStepsCount()
        let isLastStep = index == total - 1
        
        if isLastSection && isLastStep {
            completeSection()
            return
        }
        
        // Otherwise, move to the next step/section
        let navigated = interactor.moveToNextStep()
        
        if !navigated && interactor.isLastSectionAndStep() {
            completeSection()
        }
    }
    
    func navigateToPreviousStep() {
        guard let interactor = interactor else { return }
        
        // Try to navigate to the previous step within the current section first
        _ = interactor.moveToPreviousStep()
    
        // The interactor will handle cross-section navigation internally
        // and call didUpdateSection or navigateToWelcome as appropriate
    }
    
    func completeSection() {
        guard let interactor = interactor else { return }
        
        if interactor.isLastSectionAndStep() {
            // If this is the last step of the last section, go to the questions
            router?.navigateToQuestions(from: view)
        } else {
            // Otherwise, go to the next section
            router?.navigateToNextSection(from: view)
        }
    }
    
    func skipToMainMenu() {
        router?.navigateToMainMenu(from: view)
    }
    
    func getCurrentSection() -> TutorialSection {
        return interactor?.getCurrentSection() ?? .introduction
    }
    
    func getCurrentStepIndex() -> Int {
        return interactor?.getCurrentStepIndex() ?? 0
    }
    
    func getTotalStepsCount() -> Int {
        return interactor?.getTotalStepsCount() ?? 0
    }
    
    func getCurrentStep() -> TutorialStep {
        guard let interactor = interactor else {
            // a fallback step if interactor is not available
            return TutorialStep(
                title: "Loading...",
                description: "Please wait while the tutorial loads.",
                image: "hourglass",
                equation: nil,
                steps: nil
            )
        }
        
        return interactor.getCurrentStep()
    }
    
    // MARK: - TutorialInteractorOutputProtocol
    func didUpdateCurrentStep() {
        updateViewWithCurrentStep()
    }
    
    func didUpdateSection() {
        updateViewWithCurrentSectionAndStep()
    }
    
    func didReachEndOfTutorial() {
        router?.navigateToQuestions(from: view)
    }
    
    func navigateToWelcome() {
        router?.navigateToMainMenu(from: view)
    }
    
    // MARK: - Private Methods
    private func updateViewWithCurrentStep() {
        guard let interactor = interactor, let view = view else { return }
        
        let step = interactor.getCurrentStep()
        let index = interactor.getCurrentStepIndex()
        let total = interactor.getTotalStepsCount()
        let currentSection = interactor.getCurrentSection()
        
        // Determine if this is the first step (can't go back)
        let isFirstSection = currentSection == TutorialSection.allCases.first
        let isFirstStep = index == 0
        let isVeryFirstStep = isFirstSection && isFirstStep
        
        // Determine if this is the last step (special button text)
        let isLastSection = currentSection == TutorialSection.allCases.last
        let isLastStep = index == total - 1
        let isVeryLastStep = isLastSection && isLastStep
        
        // Update the view with step details
        view.displayStep(
            title: step.title,
            description: step.description,
            equation: step.equation
        )
        
        // Update the view with steps content
        view.displaySteps(step.steps ?? [])
        
        // Update navigation buttons
        view.configureNavigation(
            isPreviousEnabled: !isVeryFirstStep,
            isLastStep: isVeryLastStep
        )
    }
    
    private func updateViewWithCurrentSectionAndStep() {
        guard let interactor = interactor, let view = view else { return }
        
        // Update section in the view
        let section = interactor.getCurrentSection()
        view.showSection(section)
        
        // Update step content
        updateViewWithCurrentStep()
    }
} 
