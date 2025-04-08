//
//  OnboardingViewController.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 08/04/25.
//

import UIKit
import SwiftUI


class OnboardingViewController: UIViewController, OnboardingViewProtocol {
    var presenter: OnboardingPresenterProtocol?
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "illustration-onboarding")
        return imageView
    }()
    
    private let bottomContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.celestialBlue
        return view
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Can You Crack\nthe Code of x?"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Learn to solve equations like ax + b = c in a fun, step-by-step way. You'll be a master in no time!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let readyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("I'm Ready!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: - OnboardingViewProtocol
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        view.addSubview(containerView)
        containerView.addSubview(illustrationImageView)
        containerView.addSubview(bottomContainer)
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
        
        bottomContainer.addSubview(labelsStackView)
        bottomContainer.addSubview(readyButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            illustrationImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            illustrationImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            illustrationImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            illustrationImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.45),
            
            bottomContainer.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor),
            bottomContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            readyButton.heightAnchor.constraint(equalToConstant: 56),
            readyButton.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 24),
            readyButton.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -24),
            readyButton.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor, constant: -24),
            
            labelsStackView.topAnchor.constraint(greaterThanOrEqualTo: bottomContainer.topAnchor, constant: 24),
            labelsStackView.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor, constant: -32),
            labelsStackView.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 24),
            labelsStackView.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -24),
            labelsStackView.bottomAnchor.constraint(lessThanOrEqualTo: readyButton.topAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 48),
            descriptionLabel.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -48)
        ])
        
        // Add button target
        readyButton.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func readyButtonTapped() {
        presenter?.didTapReadyButton()
    }
}

// MARK: - Preview Provider
#if DEBUG
struct OnboardingViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewController = OnboardingViewController()
            
            let router = OnboardingRouter()
            let interactor = OnboardingInteractor()
            let presenter = OnboardingPresenter(view: viewController)
            
            viewController.presenter = presenter
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return viewController
        }
    }
}

#endif
