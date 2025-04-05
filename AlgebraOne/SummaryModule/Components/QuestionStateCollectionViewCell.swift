//
//  QuestionStateCollectionViewCell.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 03/04/25.
//

import UIKit

class QuestionStateCollectionViewCell: UICollectionViewCell {
    
    private let stateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = AppStyle.Spacing.medium
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(stateView)
        
        NSLayoutConstraint.activate([
            stateView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(isTrue: Bool) {
        stateView.backgroundColor = isTrue ? UIColor.forestGreen : UIColor.fireOpal
    }
}
