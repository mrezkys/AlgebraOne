//
//  TutorialInteractor.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import Foundation

class TutorialInteractor: TutorialInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: TutorialInteractorOutputProtocol?
    
    private var currentSection: TutorialSection = .introduction
    private var currentStepIndex: Int = 0
    private var tutorialSteps: [TutorialStep] = []
    
    // MARK: - Initialization
    init() {
        // Load the tutorial content for the initial section
        loadCurrentSectionContent()
    }
    
    // MARK: - Private Methods
    private func loadCurrentSectionContent() {
        tutorialSteps = TutorialContent.getContent(for: currentSection)
    }
    
    // MARK: - TutorialInteractorProtocol
    func getCurrentSection() -> TutorialSection {
        return currentSection
    }
    
    func setCurrentSection(_ section: TutorialSection) {
        if currentSection != section {
            currentSection = section
            currentStepIndex = 0
            loadCurrentSectionContent()
            presenter?.didUpdateSection()
        }
    }
    
    func getCurrentStepIndex() -> Int {
        return currentStepIndex
    }
    
    func setCurrentStepIndex(_ index: Int) {
        guard index >= 0 && index < tutorialSteps.count else { return }
        
        currentStepIndex = index
        presenter?.didUpdateCurrentStep()
    }
    
    func getCurrentStep() -> TutorialStep {
        return tutorialSteps[currentStepIndex]
    }
    
    func getTotalStepsCount() -> Int {
        return tutorialSteps.count
    }
    
    func hasNextStep() -> Bool {
        return currentStepIndex < tutorialSteps.count - 1
    }
    
    func hasPreviousStep() -> Bool {
        return currentStepIndex > 0
    }
    
    func moveToNextStep() -> Bool {
        if hasNextStep() {
            currentStepIndex += 1
            presenter?.didUpdateCurrentStep()
            return true
        } else if let nextSection = getNextSection() {
            currentSection = nextSection
            currentStepIndex = 0
            loadCurrentSectionContent()
            presenter?.didUpdateSection()
            return true
        } else {
            // We're at the last step of the last section
            presenter?.didReachEndOfTutorial()
            return false
        }
    }
    
    func moveToPreviousStep() -> Bool {
        if hasPreviousStep() {
            currentStepIndex -= 1
            presenter?.didUpdateCurrentStep()
            return true
        } else if let previousSection = getPreviousSection() {
            currentSection = previousSection
            // Set to the last step of the previous section
            loadCurrentSectionContent()
            currentStepIndex = tutorialSteps.count - 1
            presenter?.didUpdateSection()
            return true
        } else {
            // We're at the first step of the first section, go back to welcome
            presenter?.navigateToWelcome()
            return false
        }
    }
    
    func isLastSectionAndStep() -> Bool {
        let isLastSection = currentSection == TutorialSection.allCases.last
        let isLastStep = currentStepIndex == tutorialSteps.count - 1
        return isLastSection && isLastStep
    }
    
    // MARK: - Helper Methods
    private func getNextSection() -> TutorialSection? {
        let allSections = TutorialSection.allCases
        guard let currentIndex = allSections.firstIndex(of: currentSection),
              currentIndex < allSections.count - 1 else {
            return nil
        }
        return allSections[currentIndex + 1]
    }
    
    private func getPreviousSection() -> TutorialSection? {
        let allSections = TutorialSection.allCases
        guard let currentIndex = allSections.firstIndex(of: currentSection),
              currentIndex > 0 else {
            return nil
        }
        return allSections[currentIndex - 1]
    }
} 
