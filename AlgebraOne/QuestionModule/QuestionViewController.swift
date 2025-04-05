//
//  QuestionViewController.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit
import SwiftUI

class QuestionViewController: UIViewController, QuestionViewProtocol {
    
    // MARK: - Properties
    var presenter: QuestionPresenterProtocol?
    
    // MARK: - UI Components
    private let bookIllustrationImageView = UIImageView()
    private let progressStackView = UIStackView()
    private let questionContainerView = UIView()
    private let questionContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = AppStyle.Spacing.medium
        stack.alignment = .center
        return stack
    }()
    private let questionLabel = UILabel()
    private let equationLabel = UILabel()
    private let helpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Solution", for: .normal)
        button.setTitleColor(UIColor.celestialBlue, for: .normal)
        button.titleLabel?.font = AppStyle.Fonts.body
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 32, bottom: 8, right: 32)
        return button
    }()
    private let answersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = AppStyle.Spacing.medium
        layout.minimumLineSpacing = AppStyle.Spacing.medium
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    private let nextButton = UIBarButtonItem()
    
    private var progressIndicators: [UIView] = []
    private var answerOptions: [Double] = []
    private var hasSelectedAnswer = false
    
    private var isReviewMode = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: - QuestionViewProtocol
    func configureInitialState(questionsCount: Int) {
        view.backgroundColor = AppStyle.Colors.background
        title = "Lets Calculate 🤓"
        
        nextButton.title = "Next"
        nextButton.isEnabled = false
        navigationItem.rightBarButtonItem = nextButton
        nextButton.target = self
        nextButton.action = #selector(nextButtonTapped)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        
        questionContainerView.backgroundColor = UIColor.celestialBlue
        questionContainerView.layer.cornerRadius = 16
        
        // Question label setup
        questionLabel.text = "What is the value of x?"
        AppStyle.styleSubheadingLabel(questionLabel)
        questionLabel.textColor = .white
        questionLabel.textAlignment = .center
        
        // Equation label setup
        equationLabel.text = "Loading equation..."
        AppStyle.styleHeadingLabel(equationLabel)
        equationLabel.textColor = .white
        equationLabel.textAlignment = .center
        
        // Help button setup
        helpButton.addTarget(self, action: #selector(helpButtonTapped), for: .touchUpInside)
        helpButton.isHidden = true

        setupBookImageView()
        
        // Setup progress indicators
        setupProgressIndicators(count: questionsCount)
        
        // Setup collection view
        setupCollectionView()
        
        // Add subviews and setup constraints
        setupViewHierarchy()
        setupConstraints()
    }

    func setupProgressIndicators(count: Int) {
        progressStackView.axis = .horizontal
        progressStackView.distribution = .fillEqually
        progressStackView.spacing = 4
        
        for _ in 0..<count {
            let indicator = UIView()
            indicator.backgroundColor = UIColor.water
            indicator.layer.cornerRadius = 2
            
            progressStackView.addArrangedSubview(indicator)
            progressIndicators.append(indicator)
        }
    }

    func setupCollectionView() {
        answersCollectionView.register(AnswerCollectionViewCell.self, forCellWithReuseIdentifier: "AnswerCell")
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
    }

    func setupViewHierarchy() {
        view.addSubview(progressStackView)
        view.addSubview(questionContainerView)
        
        questionContentStack.addArrangedSubview(questionLabel)
        questionContentStack.addArrangedSubview(equationLabel)
        questionContentStack.addArrangedSubview(helpButton)
        
        questionContainerView.addSubview(questionContentStack)
        view.addSubview(answersCollectionView)
    }
    
    private func setupConstraints() {
        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        questionContainerView.translatesAutoresizingMaskIntoConstraints = false
        questionContentStack.translatesAutoresizingMaskIntoConstraints = false
        answersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Progress indicators constraints
            progressStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppStyle.Spacing.medium),
            progressStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppStyle.Spacing.large),
            progressStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppStyle.Spacing.large),
            progressStackView.heightAnchor.constraint(equalToConstant: 6),
            
            // Question container constraints
            questionContainerView.topAnchor.constraint(equalTo: progressStackView.bottomAnchor, constant: AppStyle.Spacing.large),
            questionContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppStyle.Spacing.large),
            questionContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppStyle.Spacing.large),
            
            // Question content stack constraints
            questionContentStack.topAnchor.constraint(equalTo: questionContainerView.topAnchor, constant: AppStyle.Spacing.extraLarge),
            questionContentStack.leadingAnchor.constraint(equalTo: questionContainerView.leadingAnchor, constant: AppStyle.Spacing.medium),
            questionContentStack.trailingAnchor.constraint(equalTo: questionContainerView.trailingAnchor, constant: -AppStyle.Spacing.medium),
            questionContentStack.bottomAnchor.constraint(equalTo: questionContainerView.bottomAnchor, constant: -AppStyle.Spacing.extraLarge),
            
            // Answers collection view constraints
            answersCollectionView.topAnchor.constraint(equalTo: questionContainerView.bottomAnchor, constant: AppStyle.Spacing.extraLarge),
            answersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppStyle.Spacing.large),
            answersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppStyle.Spacing.large),
            answersCollectionView.heightAnchor.constraint(equalToConstant: 2 * (UIScreen.main.bounds.width - 3 * AppStyle.Spacing.large) / 2 + AppStyle.Spacing.medium)
        ])
    }
    
    private func setupBookImageView() {
        bookIllustrationImageView.translatesAutoresizingMaskIntoConstraints = false
        bookIllustrationImageView.image = UIImage(named: "book-illustration")
        bookIllustrationImageView.contentMode = .scaleAspectFit
        view.addSubview(bookIllustrationImageView)
        
        NSLayoutConstraint.activate([
            bookIllustrationImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bookIllustrationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bookIllustrationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bookIllustrationImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func updateView() {
        if let presenter = presenter {
            // Update equation text
            equationLabel.text = presenter.getEquationText()
            
            // Update answer options
            answerOptions = presenter.getAnswerOptions()
            answersCollectionView.reloadData()
        }
    }
    
    func resetUIForNewQuestion() {
        answersCollectionView.isUserInteractionEnabled = true
        answersCollectionView.reloadData()
    }
    
    func updateUIForAnswer(isCorrect: Bool, at index: Int) {
        answersCollectionView.isUserInteractionEnabled = false
        
        if let cell = answersCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? AnswerCollectionViewCell {
            if isCorrect {
                cell.setCorrectState()
            } else {
                cell.setIncorrectState()
            }
        }
    }
    
    func setNextButtonEnabled(_ enabled: Bool) {
        nextButton.isEnabled = enabled
    }
    
    func setHelpButtonVisible(_ visible: Bool) {
        helpButton.isHidden = !visible
    }
    
    func updateProgressIndicator(at index: Int, isCorrect: Bool) {
        guard index < progressIndicators.count else { return }
        progressIndicators[index].backgroundColor = isCorrect ? UIColor.forestGreen : UIColor.fireOpal
    }
    
    
    // MARK: - Actions
    @objc private func helpButtonTapped() {
        presenter?.showHelp()
    }
    
    @objc private func nextButtonTapped() {
        presenter?.goToNextQuestion()
    }
    
    @objc private func backButtonTapped() {
        presenter?.handleBackButtonTapped()
    }

    func showEndSessionConfirmation(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(
            title: "End Session",
            message: "Are you sure you want to end this session?",
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            completion(true)
        }
        let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
            completion(false)
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    
    private func answerButtonTapped(tag: Int) {
        presenter?.checkAnswer(at: tag)
    }
}

extension QuestionViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout
    @objc public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 3 * AppStyle.Spacing.large) / 2
        return CGSize(width: width, height: width)
    }
    
    // MARK: - UICollectionViewDataSource
    @objc public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    @objc public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCell", for: indexPath) as! AnswerCollectionViewCell
        if indexPath.item < answerOptions.count {
            cell.configure(with: String(Int(answerOptions[indexPath.item])), tag: indexPath.item)
        }
        cell.onTap = { [weak self] tag in
            self?.answerButtonTapped(tag: tag)
        }
        return cell
    }
}

// MARK: - Preview Provider
#if DEBUG
struct QuestionViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewController = QuestionViewController()
            let router = QuestionRouter()
            let interactor = QuestionInteractor()
            let presenter = QuestionPresenter(view: viewController)
            
            let equation = EquationModel(
                question: "2x + 3 = 7",
                correctAnswer: 2.0,
                steps: ["Step 1: Subtract 3 from both sides", "Step 2: 2x = 4", "Step 3: Divide both sides by 2", "Step 4: x = 2"]
            )
            
            viewController.presenter = presenter
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.equation = equation
            
            viewController.loadViewIfNeeded()
            presenter.viewDidLoad()
            
            return viewController
        }
    }
}
#endif 
