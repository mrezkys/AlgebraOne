//
//  SummaryViewController.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit
import SwiftUI

class SummaryViewController: UIViewController, SummaryViewProtocol {
    // MARK: - Properties
    var presenter: SummaryPresenterProtocol?
    
    // MARK: - UI Components
    private let questionsStatesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppStyle.Fonts.heading
        label.textColor =  .black
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppStyle.Fonts.body
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.illustrationOkay
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Configuration properties
    private var questionsHistory: [QuestionHistory] = []
    private var itemCount: Int = 12
    private var numberOfItemsPerRow: Int = 4
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = AppStyle.Colors.background
        title = "Session Summary"
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Finish",
            style: .done,
            target: self,
            action: #selector(finishSessionTapped)
        )
        
        setupQuestionStatesCollectionView()
        setupLabels()
        setupImage()
    }
    
    private func setupQuestionStatesCollectionView() {
        view.addSubview(questionsStatesCollectionView)
        
        questionsStatesCollectionView.delegate = self
        questionsStatesCollectionView.dataSource = self
        questionsStatesCollectionView.register(QuestionStateCollectionViewCell.self, forCellWithReuseIdentifier: "QuestionStateCollectionViewCellIdentifier")
        
        // Question States Collection View Constraints
        questionsStatesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Calculate number of rows
        let numberOfRows = ceil(CGFloat(itemCount) / CGFloat(numberOfItemsPerRow))
        let cellSize = calculateCellSize()
        let totalHeight = (numberOfRows * cellSize.height) + ((numberOfRows - 1) * AppStyle.Spacing.medium)
        
        NSLayoutConstraint.activate([
            questionsStatesCollectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: AppStyle.Spacing.extraLarge),
            questionsStatesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AppStyle.Spacing.large),
            questionsStatesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AppStyle.Spacing.large),
            questionsStatesCollectionView.heightAnchor.constraint(equalToConstant: totalHeight)
        ])
    }
    
    private func setupLabels() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        titleLabel.text = "Loading Answer..."
        titleLabel.numberOfLines = 0
        subtitleLabel.text = presenter?.getEncouragingMessage()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppStyle.Spacing.large),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AppStyle.Spacing.large),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AppStyle.Spacing.large)
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: AppStyle.Spacing.medium),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AppStyle.Spacing.large),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AppStyle.Spacing.large)
        ])
    }
    
    private func setupImage() {
        view.addSubview(illustrationImageView)

        illustrationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            illustrationImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            illustrationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -AppStyle.Spacing.medium),
            illustrationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            illustrationImageView.topAnchor.constraint(equalTo: questionsStatesCollectionView.bottomAnchor, constant: AppStyle.Spacing.extraLarge)
        ])
    }
    
    private func calculateCellSize() -> CGSize {
        let spacingBetweenCells: CGFloat = AppStyle.Spacing.medium
        // Get the total width of the collection view
        let totalWidth = view.bounds.width - (2 * AppStyle.Spacing.large)
        // Calculate the width of each cell
        let cellWidth = (totalWidth - (CGFloat(numberOfItemsPerRow - 1) * spacingBetweenCells)) / CGFloat(numberOfItemsPerRow)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    // MARK: - Actions
    @objc private func finishSessionTapped() {
        presenter?.startNewSession()
    }
    
    // MARK: - SummaryViewProtocol
    func updateView() {
        // Update the view with data from the presenter
        titleLabel.text = "You answer \(presenter?.getQuestionsAnsweredTrue() ?? 0) Correct Question"
        
        questionsHistory = presenter?.getQuestionsHistory() ?? []
        itemCount = questionsHistory.count
        subtitleLabel.text = presenter?.getEncouragingMessage() ?? "" + " Click Box below to review your past Answer."
        
        // Recalculate and update collection view
        questionsStatesCollectionView.reloadData()
        
        // Recalculate height
        let numberOfRows = ceil(CGFloat(itemCount) / CGFloat(numberOfItemsPerRow))
        let cellSize = calculateCellSize()
        let totalHeight = (numberOfRows * cellSize.height) + ((numberOfRows - 1) * AppStyle.Spacing.medium)
        
        // Update height constraint
        questionsStatesCollectionView.constraints.first { $0.firstAttribute == .height }?.constant = totalHeight
        questionsStatesCollectionView.layoutIfNeeded()
    }
}

extension SummaryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionStateCollectionViewCellIdentifier", for: indexPath) as? QuestionStateCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let isCorrect = questionsHistory[safe: indexPath.row]?.isCorrect {
            cell.configure(isTrue: isCorrect)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.reviewQuestion(questionHistory: questionsHistory[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return AppStyle.Spacing.medium
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return AppStyle.Spacing.medium
    }
}

// MARK: - Preview Provider
#if DEBUG
struct SummaryViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewController = SummaryViewController()
            let router = SummaryRouter()
            let interactor = SummaryInteractor()
            let presenter = SummaryPresenter(view: viewController)
            
            viewController.presenter = presenter
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            // Set some sample data for preview
            interactor.questionsHistory = [
                QuestionHistory(
                    equation: EquationModel(
                        question: "What is 3x + 5 = 14?",
                        correctAnswer: 3.0,
                        steps: [
                            "Subtract 5 from both sides",
                            "Divide both sides by 3"
                        ]
                    ),
                    answers: [],
                    userAnswer: 3.0,
                    isCorrect: true
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "Solve 2x - 7 = 11",
                        correctAnswer: 9.0,
                        steps: [
                            "Add 7 to both sides",
                            "Divide both sides by 2"
                        ]
                    ),
                    answers: [],
                    userAnswer: 9.0,
                    isCorrect: true
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "What is x in 4x = 20?",
                        correctAnswer: 5.0,
                        steps: [
                            "Divide both sides by 4"
                        ]
                    ),
                    answers: [],
                    userAnswer: 5.0,
                    isCorrect: true
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "Solve 5x + 3 = 28",
                        correctAnswer: 5.0,
                        steps: [
                            "Subtract 3 from both sides",
                            "Divide both sides by 5"
                        ]
                    ),
                    answers: [],
                    userAnswer: 4.0,
                    isCorrect: false
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "What is x in 2x - 4 = 10?",
                        correctAnswer: 7.0,
                        steps: [
                            "Add 4 to both sides",
                            "Divide both sides by 2"
                        ]
                    ),
                    answers: [],
                    userAnswer: 7.0,
                    isCorrect: true
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "Solve x + 6 = 15",
                        correctAnswer: 9.0,
                        steps: [
                            "Subtract 6 from both sides"
                        ]
                    ),
                    answers: [],
                    userAnswer: 9.0,
                    isCorrect: true
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "What is 7x = 35?",
                        correctAnswer: 5.0,
                        steps: [
                            "Divide both sides by 7"
                        ]
                    ),
                    answers: [],
                    userAnswer: 5.0,
                    isCorrect: true
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "Solve 3x - 2 = 13",
                        correctAnswer: 5.0,
                        steps: [
                            "Add 2 to both sides",
                            "Divide both sides by 3"
                        ]
                    ),
                    answers: [],
                    userAnswer: 6.0,
                    isCorrect: false
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "What is x in 6x = 42?",
                        correctAnswer: 7.0,
                        steps: [
                            "Divide both sides by 6"
                        ]
                    ),
                    answers: [],
                    userAnswer: 7.0,
                    isCorrect: true
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "Solve x - 5 = 8",
                        correctAnswer: 13.0,
                        steps: [
                            "Add 5 to both sides"
                        ]
                    ),
                    answers: [],
                    userAnswer: 13.0,
                    isCorrect: true
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "What is 4x + 3 = 19?",
                        correctAnswer: 4.0,
                        steps: [
                            "Subtract 3 from both sides",
                            "Divide both sides by 4"
                        ]
                    ),
                    answers: [],
                    userAnswer: 4.0,
                    isCorrect: true
                ),
                QuestionHistory(
                    equation: EquationModel(
                        question: "Solve 5x = 25",
                        correctAnswer: 5.0,
                        steps: [
                            "Divide both sides by 5"
                        ]
                    ),
                    answers: [],
                    userAnswer: 5.0,
                    isCorrect: true
                )
            ]
            
            // Simulate viewDidLoad to populate UI
            viewController.loadViewIfNeeded()
            presenter.viewDidLoad()
            
            return viewController
        }
    }
}
#endif
