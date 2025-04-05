//
//  WelcomeViewController.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit
import SwiftUI

class WelcomeViewController: UIViewController, WelcomeViewProtocol {

    // MARK: - Properties
    var presenter: WelcomePresenterProtocol?
    let bookIllustrationImage: UIImageView = UIImageView()
    let illustrationImage: UIImageView = UIImageView()
    let startButton: UIButton = UIButton()
    let tutorialLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = AppStyle.Colors.background
        setNeedsStatusBarAppearanceUpdate()
        
        setupIllustrationImageView()
        setupStartButton()
        setupBookImageView()
        setupTutorialButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setupBookImageView() {
        bookIllustrationImage.translatesAutoresizingMaskIntoConstraints = false
        bookIllustrationImage.image = UIImage(named: "book-illustration")
        bookIllustrationImage.contentMode = .scaleAspectFit
        view.addSubview(bookIllustrationImage)
        
        NSLayoutConstraint.activate([
            bookIllustrationImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bookIllustrationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bookIllustrationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bookIllustrationImage.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupIllustrationImageView() {
        illustrationImage.translatesAutoresizingMaskIntoConstraints = false
        illustrationImage.image = UIImage(named: "illustration")
        illustrationImage.contentMode = .scaleAspectFit
        
        view.addSubview(illustrationImage)
        NSLayoutConstraint.activate([
            illustrationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            illustrationImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
        ])
    }
    
    private func setupStartButton() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = UIColor.celestialBlue
        startButton.layer.cornerRadius = 12
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        let playImage = UIImage(systemName: "play.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 40))
        startButton.setImage(playImage, for: .normal)
        
        view.addSubview(startButton)
    }
    
    private func setupTutorialButton() {
        tutorialLabel.translatesAutoresizingMaskIntoConstraints = false
        tutorialLabel.text = "Doesnt Understand Yet? Tutorial"
        tutorialLabel.textAlignment = .center
        
        // Make "Tutorial" blue and underlined
        let fullText = "Doesnt Understand Yet? Tutorial"
        let attributedString = NSMutableAttributedString(string: fullText)
        let tutorialRange = (fullText as NSString).range(of: "Tutorial")
        attributedString.addAttribute(.foregroundColor, value: UIColor.celestialBlue, range: tutorialRange)
        
        tutorialLabel.attributedText = attributedString
        
        tutorialLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tutorialLabelTapped))
        tutorialLabel.addGestureRecognizer(tapGesture)
        
        view.addSubview(tutorialLabel)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: illustrationImage.bottomAnchor, constant: 24),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            startButton.heightAnchor.constraint(equalToConstant: 100),
            
            tutorialLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialLabel.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 24)
        ])
    }
    
    // MARK: - Actions
    @objc private func startButtonTapped() {
        presenter?.startLearning()
    }
    
    @objc private func tutorialLabelTapped() {
        presenter?.showTutorial()
    }
}

// MARK: - Preview Provider
#if DEBUG
struct WelcomeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewController = WelcomeViewController()
            
            let router = WelcomeRouter()
            let interactor = WelcomeInteractor()
            let presenter = WelcomePresenter(view: viewController)
            
            viewController.presenter = presenter
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return viewController
        }
    }
}

#endif
