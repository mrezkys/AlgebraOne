//
//  TutorialStepCell.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 03/04/25.
//

import UIKit

// MARK: - TutorialStepCell
class TutorialStepCell: UITableViewCell {
    private let stepLabel = UILabel()
    private let containerView = UIView()
    private let separatorView = UIView()
    private let iconView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        // Container view setup
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowOpacity = 0 // Remove shadow
        
        // Separator view setup
        separatorView.backgroundColor = UIColor.water.withAlphaComponent(0.5)
        separatorView.isHidden = true
        separatorView.layer.cornerRadius = 0
        
        // Icon view setup
        iconView.tintColor = UIColor.celestialBlue
        iconView.contentMode = .scaleAspectFit
        iconView.isHidden = true
        
        // Step label setup
        stepLabel.font = AppStyle.Fonts.body
        stepLabel.textColor = UIColor.darkGray
        stepLabel.numberOfLines = 0
        
        // Add subviews
        contentView.addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(stepLabel)
        containerView.addSubview(separatorView)
        
        // Set up constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 16),
            iconView.heightAnchor.constraint(equalToConstant: 16),
            
            stepLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            stepLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 6),
            stepLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            stepLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(with step: StepModel) {
        stepLabel.text = step.text
        
        // Empty strings are used as spacers
        if step.type == .spacer {
            containerView.backgroundColor = .clear
            containerView.layer.shadowOpacity = 0
            separatorView.isHidden = true
            stepLabel.isHidden = true
            iconView.isHidden = true
            return
        }
        
        stepLabel.isHidden = false
        
        switch step.type {
        case .header:
            containerView.backgroundColor = UIColor.celestialBlue.withAlphaComponent(0.05)
            stepLabel.font = AppStyle.Fonts.bodyBold
            stepLabel.textColor = UIColor.celestialBlue
            stepLabel.textAlignment = .left
            separatorView.isHidden = false
            iconView.isHidden = false
            iconView.image = UIImage(systemName: "chevron.right")
            iconView.tintColor = UIColor.celestialBlue
        
        case .equation:
            containerView.backgroundColor = UIColor.water.withAlphaComponent(0.02)
            stepLabel.font = AppStyle.Fonts.bodyBold
            stepLabel.textColor = UIColor.darkText
            stepLabel.textAlignment = .center
            separatorView.isHidden = true
            iconView.isHidden = true
        
        case .verification:
            containerView.backgroundColor = UIColor.forestGreen.withAlphaComponent(0.05)
            stepLabel.font = AppStyle.Fonts.bodyBold
            stepLabel.textColor = UIColor.forestGreen
            stepLabel.textAlignment = .center
            separatorView.isHidden = true
            iconView.isHidden = false
            iconView.image = UIImage(systemName: "checkmark")
            iconView.tintColor = UIColor.forestGreen
        
        case .explanation:
            containerView.backgroundColor = .white
            stepLabel.font = AppStyle.Fonts.body
            stepLabel.textColor = UIColor.darkGray
            stepLabel.textAlignment = .left
            separatorView.isHidden = true
            iconView.isHidden = true
        
        case .spacer:
            // Already handled above
            break
        }
        
        // Setup accessibility
        containerView.isAccessibilityElement = true
        containerView.accessibilityLabel = step.text
        containerView.accessibilityTraits = .staticText
    }
}
