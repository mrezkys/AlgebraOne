//
//  TutorialViewController.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit
import SwiftUI

class TutorialViewController: UIViewController, TutorialViewProtocol {
    
    // MARK: - Properties
    var presenter: TutorialPresenterProtocol?
    
    // MARK: - UI Components
    private let headerContainerView = UIView()
    private let progressStackView = UIStackView()
    private let sectionLabel = UILabel()
    private let contentScrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let equationContainerView = UIView()
    private let equationLabel = UILabel()
    private let stepsTableView = UITableView()
    
    private let navigationView = UIView()
    private let previousButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    
    private var progressIndicators: [UIView] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update table view height when layout changes
        if !stepsTableView.isHidden {
            updateTableViewHeight()
        }
    }
    
    // MARK: - TutorialViewProtocol
    func configureInitialState() {
        // View setup
        view.backgroundColor = AppStyle.Colors.background
        title = "Linear Equations Tutorial"
        
        // Navigation setup
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitButtonTapped))
        
        // Set up UI components
        setupHeaderContainer()
        setupProgressIndicators()
        setupSectionLabel()
        setupContentScrollView()
        setupNavigationView()
        
        // Set up content elements
        setupContentElements()
        
        // Add subviews and set constraints
        setupViewHierarchy()
        setupConstraints()
    }
    
    func showSection(_ section: TutorialSection) {
        sectionLabel.text = "Section : \(section.title)"
        
        // Update progress indicators to show current section
        updateProgressIndicators(for: section)
    }
    
    func displayStep(title: String, description: String, equation: String?) {
        // Update title and description
        titleLabel.text = title
        descriptionLabel.text = description
        
        // Handle equation visibility
        if let equation = equation, !equation.isEmpty {
            equationLabel.text = equation
            equationContainerView.isHidden = false
        } else {
            equationContainerView.isHidden = true
        }
        
        // Reset scroll position to top when showing a new step
        contentScrollView.setContentOffset(.zero, animated: false)
    }
    
    func displaySteps(_ steps: [StepModel]) {
        // Handle steps visibility
        if !steps.isEmpty {
            self.steps = steps
            stepsTableView.isHidden = false
            stepsTableView.reloadData()
            
            // Force layout update to ensure table view sizes itself correctly
            stepsTableView.layoutIfNeeded()
            updateTableViewHeight()
        } else {
            stepsTableView.isHidden = true
            self.steps = []
        }
    }
    
    func configureNavigation(isPreviousEnabled: Bool, isLastStep: Bool) {
        // Update previous button
        previousButton.isEnabled = isPreviousEnabled
        previousButton.alpha = isPreviousEnabled ? 1.0 : 0.5
        
        // Update next button
        nextButton.setTitle(isLastStep ? "Start Practice" : "Next", for: .normal)
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
    }
    
    // MARK: - Private Properties for Table View
    private var steps: [StepModel] = []
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Private Setup Methods
    private func setupHeaderContainer() {
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        headerContainerView.backgroundColor = UIColor.celestialBlue
        headerContainerView.layer.cornerRadius = 0
        view.addSubview(headerContainerView)
    }
    
    private func setupProgressIndicators() {
        progressStackView.axis = .horizontal
        progressStackView.distribution = .fillEqually
        progressStackView.spacing = 8
        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        progressStackView.backgroundColor = .clear
        
        // Add indicators for each tutorial section
        for _ in TutorialSection.allCases {
            let indicator = UIView()
            indicator.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            indicator.layer.cornerRadius = 2
            
            progressStackView.addArrangedSubview(indicator)
            progressIndicators.append(indicator)
        }
    }
    
    private func updateProgressIndicators(for section: TutorialSection) {
        guard let sectionIndex = TutorialSection.allCases.firstIndex(of: section) else { return }
        
        for (index, indicator) in progressIndicators.enumerated() {
            if index < sectionIndex {
                // Completed sections
                indicator.backgroundColor = UIColor.white
                indicator.alpha = 1.0
            } else if index == sectionIndex {
                // Current section
                indicator.backgroundColor = UIColor.white
                indicator.alpha = 1.0
                indicator.transform = .identity
            } else {
                // Future sections
                indicator.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                indicator.alpha = 0.5
                indicator.transform = .identity
            }
        }
    }
    
    private func setupSectionLabel() {
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.font = AppStyle.Fonts.bodyBold
        sectionLabel.textColor = .white
        sectionLabel.textAlignment = .center
    }
    
    private func setupContentScrollView() {
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.showsVerticalScrollIndicator = true
        contentScrollView.alwaysBounceVertical = true
    }
    
    private func setupContentElements() {
        // Set up content stack view
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = AppStyle.Spacing.medium
        contentStackView.alignment = .fill
        contentStackView.layoutMargins = UIEdgeInsets(
            top: AppStyle.Spacing.medium,
            left: AppStyle.Spacing.medium,
            bottom: AppStyle.Spacing.large,
            right: AppStyle.Spacing.medium
        )
        contentStackView.isLayoutMarginsRelativeArrangement = true
        
        // Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = AppStyle.Fonts.heading
        titleLabel.textColor = UIColor.darkText
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        
        // Description Label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = AppStyle.Fonts.body
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        
        // Equation Container
        equationContainerView.translatesAutoresizingMaskIntoConstraints = false
        equationContainerView.backgroundColor = UIColor.celestialBlue
        equationContainerView.layer.cornerRadius = 12
        equationContainerView.layer.shadowOpacity = 0
        
        // Equation Label
        equationLabel.translatesAutoresizingMaskIntoConstraints = false
        equationLabel.font = AppStyle.Fonts.bodyBold
        equationLabel.textColor = .white
        equationLabel.textAlignment = .center
        equationLabel.numberOfLines = 1
        equationLabel.adjustsFontSizeToFitWidth = true
        equationLabel.minimumScaleFactor = 0.7
        equationLabel.isAccessibilityElement = true
        equationLabel.accessibilityTraits = .staticText
        
        // Steps Table View
        stepsTableView.translatesAutoresizingMaskIntoConstraints = false
        stepsTableView.backgroundColor = .clear
        stepsTableView.separatorStyle = .none
        stepsTableView.isScrollEnabled = false
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        stepsTableView.register(TutorialStepCell.self, forCellReuseIdentifier: "StepCell")
        stepsTableView.estimatedRowHeight = 44
        stepsTableView.rowHeight = UITableView.automaticDimension
        stepsTableView.bounces = false
        stepsTableView.showsVerticalScrollIndicator = false
        stepsTableView.isAccessibilityElement = false
        stepsTableView.accessibilityLabel = "Step-by-step solution process"
        stepsTableView.layer.cornerRadius = 0
    }
    
    private func setupNavigationView() {
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.backgroundColor = .white
        navigationView.layer.cornerRadius = 0
        navigationView.layer.shadowOpacity = 0
        
        // Add top border
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        navigationView.addSubview(borderView)
        
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: navigationView.topAnchor),
            borderView.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // Previous Button
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.setTitle("Previous", for: .normal)
        previousButton.setTitleColor(UIColor.celestialBlue, for: .normal)
        previousButton.backgroundColor = .clear
        previousButton.layer.cornerRadius = 8
        previousButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
        previousButton.titleLabel?.font = AppStyle.Fonts.bodyBold
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        
        // Next Button
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = UIColor.celestialBlue
        nextButton.layer.cornerRadius = 8
        nextButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
        nextButton.titleLabel?.font = AppStyle.Fonts.bodyBold
        nextButton.layer.shadowOpacity = 0
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupViewHierarchy() {
        // Add main components to view
        view.addSubview(headerContainerView)
        headerContainerView.addSubview(progressStackView)
        headerContainerView.addSubview(sectionLabel)
        view.addSubview(contentScrollView)
        view.addSubview(navigationView)
        
        // Set up equation container
        equationContainerView.addSubview(equationLabel)
        
        // Set up navigation view
        navigationView.addSubview(previousButton)
        navigationView.addSubview(nextButton)
        
        // Set up content stack view
        contentScrollView.addSubview(contentStackView)
        
        // Add elements to content stack view
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(equationContainerView)
        contentStackView.addArrangedSubview(stepsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Header container
            headerContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            // Section label constraints
            sectionLabel.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: AppStyle.Spacing.large),
            sectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppStyle.Spacing.large),
            sectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppStyle.Spacing.large),
            sectionLabel.bottomAnchor.constraint(equalTo: progressStackView.topAnchor, constant: -AppStyle.Spacing.medium),
            
            
            // Progress indicators constraints
            progressStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppStyle.Spacing.large),
            progressStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppStyle.Spacing.large),
            progressStackView.heightAnchor.constraint(equalToConstant: 4),
            progressStackView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: -AppStyle.Spacing.large),
            
            
            // Content scroll view constraints
            contentScrollView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: navigationView.topAnchor),
            
            // Content stack view constraints
            contentStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: AppStyle.Spacing.small),
            contentStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: AppStyle.Spacing.medium),
            contentStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor, constant: -AppStyle.Spacing.medium),
            contentStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -AppStyle.Spacing.medium),
            contentStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -AppStyle.Spacing.medium * 2),
            
            // Equation label constraints
            equationLabel.topAnchor.constraint(equalTo: equationContainerView.topAnchor, constant: AppStyle.Spacing.medium),
            equationLabel.leadingAnchor.constraint(equalTo: equationContainerView.leadingAnchor, constant: AppStyle.Spacing.medium),
            equationLabel.trailingAnchor.constraint(equalTo: equationContainerView.trailingAnchor, constant: -AppStyle.Spacing.medium),
            equationLabel.bottomAnchor.constraint(equalTo: equationContainerView.bottomAnchor, constant: -AppStyle.Spacing.medium),
            
            // Navigation view constraints
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 60),
            
            // Previous button constraints
            previousButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: AppStyle.Spacing.large),
            previousButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
            
            // Next button constraints
            nextButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: -AppStyle.Spacing.large),
            nextButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func exitButtonTapped() {
        presenter?.skipToMainMenu()
    }
    
    @objc private func previousButtonTapped() {
        // This will trigger navigation to previous step or previous section as needed
        presenter?.navigateToPreviousStep()
    }
    
    @objc private func nextButtonTapped() {
        // Let the presenter handle the navigation logic
        presenter?.navigateToNextStep()
    }
    
    func updateTableViewHeight() {
        // Force layout update
        stepsTableView.layoutIfNeeded()
        
        // Calculate content height
        let contentHeight = stepsTableView.contentSize.height
        
        // Set height constraint based on content
        if tableViewHeightConstraint == nil {
            tableViewHeightConstraint = stepsTableView.heightAnchor.constraint(equalToConstant: contentHeight)
            tableViewHeightConstraint?.isActive = true
        } else {
            tableViewHeightConstraint?.constant = contentHeight
        }
        
        // Force another layout update
        view.layoutIfNeeded()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TutorialViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath) as! TutorialStepCell
        let stepModel = steps[indexPath.row]
        
        // Configure cell with the StepModel
        cell.configure(with: stepModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



// MARK: - Preview Provider
#if DEBUG
struct TutorialViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Create the view controller
            let viewController = TutorialViewController()
            
            // Set up the VIPER components
            let router = TutorialRouter()
            let interactor = TutorialInteractor()
            let presenter = TutorialPresenter(view: viewController)
            
            // Connect the components
            viewController.presenter = presenter
            presenter.view = viewController
            presenter.interactor = interactor
            presenter.router = router
            interactor.presenter = presenter
            
            return viewController
        }
    }
}
#endif 
