//
//  SolutionViewController.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit
import SwiftUI

class SolutionViewController: UIViewController, SolutionViewProtocol {
    
    // MARK: - Properties
    var presenter: SolutionPresenterProtocol?
    
    // MARK: - UI Components
    private let bookIllustrationImageView = UIImageView()
    private let equationContainerView = UIView()
    private let equationContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = AppStyle.Spacing.medium
        stack.alignment = .center
        return stack
    }()
    private let equationLabel = UILabel()
    private let stepsTableView = UITableView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = AppStyle.Colors.background
        title = "Solution"
        
        equationContainerView.backgroundColor = UIColor.celestialBlue
        equationContainerView.layer.cornerRadius = 16
        
        equationLabel.text = "Loading equation..."
        AppStyle.styleHeadingLabel(equationLabel)
        equationLabel.textColor = .white
        equationLabel.textAlignment = .center
        
        setupBookImageView()
        
        stepsTableView.backgroundColor = UIColor.water
        stepsTableView.separatorStyle = .none
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        stepsTableView.register(StepTableViewCell.self, forCellReuseIdentifier: "StepCell")
        stepsTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        
        
        view.addSubview(equationContainerView)
        
        equationContentStack.addArrangedSubview(equationLabel)
        equationContainerView.addSubview(equationContentStack)
        
        view.addSubview(stepsTableView)
        
        setupConstraints()
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
    
    private func setupConstraints() {
        equationContainerView.translatesAutoresizingMaskIntoConstraints = false
        equationContentStack.translatesAutoresizingMaskIntoConstraints = false
        stepsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Equation container constraints
            equationContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppStyle.Spacing.large),
            equationContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppStyle.Spacing.large),
            equationContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppStyle.Spacing.large),
            
            // Equation content stack constraints
            equationContentStack.topAnchor.constraint(equalTo: equationContainerView.topAnchor, constant: AppStyle.Spacing.extraLarge),
            equationContentStack.leadingAnchor.constraint(equalTo: equationContainerView.leadingAnchor, constant: AppStyle.Spacing.medium),
            equationContentStack.trailingAnchor.constraint(equalTo: equationContainerView.trailingAnchor, constant: -AppStyle.Spacing.medium),
            equationContentStack.bottomAnchor.constraint(equalTo: equationContainerView.bottomAnchor, constant: -AppStyle.Spacing.extraLarge),
            
            // Table view constraints
            stepsTableView.topAnchor.constraint(equalTo: equationContainerView.bottomAnchor, constant: AppStyle.Spacing.large),
            stepsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stepsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stepsTableView.bottomAnchor.constraint(equalTo: bookIllustrationImageView.topAnchor, constant: -AppStyle.Spacing.medium),

        ])
    }
    
    // MARK: - Actions
    @objc private func continueButtonTapped() {
        presenter?.continueLearning()
    }
    
    // MARK: - SolutionViewProtocol
    func updateView() {
        if let presenter = presenter {
            equationLabel.text = presenter.getEquationText()
            stepsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SolutionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let presenter = presenter {
            return presenter.getStepsCount()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath) as? StepTableViewCell,
              let presenter = presenter else {
            return UITableViewCell()
        }
        
        let step = presenter.getStep(at: indexPath.row)
        cell.configure(with: step, stepNumber: indexPath.row + 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Preview Provider
#if DEBUG
struct SolutionViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewController = SolutionViewController()
            let router = SolutionRouter()
            let equation = EquationModel(
                question: "2x + 3 = 7",
                correctAnswer: 2.0,
                steps: [
                    "Subtract 3 from both sides: 2x + 3 - 3 = 7 - 3",
                    "Simplify: 2x = 4",
                    "Divide both sides by 2: 2x ÷ 2 = 4 ÷ 2",
                    "Simplify: x = 2"
                ]
            )
            let interactor = SolutionInteractor(equation: equation)
            let presenter = SolutionPresenter(view: viewController)
            
            viewController.presenter = presenter
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            // Simulate viewDidLoad to populate UI
            viewController.loadViewIfNeeded()
            presenter.viewDidLoad()
            
            return viewController
        }
    }
}
#endif 
