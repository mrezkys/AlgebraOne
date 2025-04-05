//
//  AnswerCollectionViewCell.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 03/04/25.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {
    private let answerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        button.backgroundColor = UIColor.water
        button.layer.cornerRadius = 16
        return button
    }()
    
    var onTap: ((Int) -> Void)?
    private var buttonTag: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(answerButton)
        answerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            answerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            answerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            answerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        answerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func configure(with title: String, tag: Int) {
        answerButton.setTitle(title, for: .normal)
        buttonTag = tag
        answerButton.tag = tag
    }
    
    @objc private func buttonTapped() {
        onTap?(buttonTag)
    }
    
    func setCorrectState() {
        print("DEBUG: Setting correct state")

        answerButton.backgroundColor = UIColor.forestGreen
        answerButton.layer.cornerRadius = bounds.width / 2
    }
    
    func setIncorrectState() {
        print("DEBUG: Setting incorrect state")

        answerButton.backgroundColor = UIColor.fireOpal
        answerButton.layer.cornerRadius = 16
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        answerButton.backgroundColor = UIColor.water
        answerButton.layer.cornerRadius = 16
        answerButton.setTitle("", for: .normal)
    }
} 
