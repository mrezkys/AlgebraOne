//
//  AppStyle.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 02/04/25.
//

import UIKit

struct AppStyle {
    // MARK: - Colors
    struct Colors {
        static let background = UIColor.white
        static let text = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
    }
    
    // MARK: - Fonts
    struct Fonts {
        static let heading = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let subheading = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let body = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let bodyBold = UIFont.systemFont(ofSize: 16, weight: .bold)
        static let caption = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    // MARK: - Button Styles
    static func styleFilledButton(_ button: UIButton) {
        button.backgroundColor = UIColor.celestialBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.bodyBold
        button.layer.cornerRadius = 16
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    static func styleOutlinedButton(_ button: UIButton) {
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.celestialBlue, for: .normal)
        button.titleLabel?.font = Fonts.bodyBold
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.celestialBlue.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    // MARK: - Label Styles
    static func styleHeadingLabel(_ label: UILabel) {
        label.font = Fonts.heading
        label.textColor = Colors.text
        label.numberOfLines = 0
    }
    
    static func styleSubheadingLabel(_ label: UILabel) {
        label.font = Fonts.subheading
        label.textColor = Colors.text
        label.numberOfLines = 0
    }
    
    static func styleBodyLabel(_ label: UILabel) {
        label.font = Fonts.body
        label.textColor = Colors.text
        label.numberOfLines = 0
    }
    
    // MARK: - View Styles
    static func styleCardView(_ view: UIView) {
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.1
    }
} 
