//
//  StepTableViewCell.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 03/04/25.
//

import UIKit

// MARK: - Step TableViewCell
class StepTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    private let stepNumberLabel = UILabel()
    private let stepDescriptionLabel = UILabel()
    private let containerView = UIView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 1
        
        stepNumberLabel.textAlignment = .center
        stepNumberLabel.textColor = .white
        stepNumberLabel.font = AppStyle.Fonts.bodyBold
        stepNumberLabel.backgroundColor = UIColor.celestialBlue
        stepNumberLabel.layer.cornerRadius = 15
        stepNumberLabel.layer.masksToBounds = true
        
        stepDescriptionLabel.font = AppStyle.Fonts.body
        stepDescriptionLabel.textColor = UIColor.darkGray
        stepDescriptionLabel.numberOfLines = 0
        
        contentView.addSubview(containerView)
        containerView.addSubview(stepNumberLabel)
        containerView.addSubview(stepDescriptionLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stepNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        stepDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppStyle.Spacing.small),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppStyle.Spacing.large),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppStyle.Spacing.large),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppStyle.Spacing.small),
            
            // Step number label constraints
            stepNumberLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AppStyle.Spacing.medium),
            stepNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AppStyle.Spacing.medium),
            stepNumberLabel.widthAnchor.constraint(equalToConstant: 30),
            stepNumberLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Step description label constraints
            stepDescriptionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AppStyle.Spacing.medium),
            stepDescriptionLabel.leadingAnchor.constraint(equalTo: stepNumberLabel.trailingAnchor, constant: AppStyle.Spacing.medium),
            stepDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AppStyle.Spacing.medium),
            stepDescriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -AppStyle.Spacing.medium),
        ])
    }
    
    // MARK: - Configuration
    func configure(with step: String, stepNumber: Int, isFinalStep: Bool = false) {
        stepNumberLabel.text = "\(stepNumber)"
        stepDescriptionLabel.text = step
        
        if isFinalStep {
            containerView.backgroundColor = UIColor.celestialBlue.withAlphaComponent(0.1)
            stepDescriptionLabel.textColor = UIColor.celestialBlue
            stepDescriptionLabel.font = AppStyle.Fonts.bodyBold
        }
    }
}

