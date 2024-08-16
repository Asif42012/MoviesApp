//
//  CategorySelectionView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

protocol CategorySelectionViewDelegate: AnyObject {
    func didTapStatsButton()
    func didTapChallengeButton()
    func didTapFaqButton()
}

class CategorySelectionView: UIView {
    
    weak var delegate: CategorySelectionViewDelegate?
    let statsButton: UIButton = {
        let statsButton = UIButton()
        statsButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        statsButton.setTitleColor(.gray, for: .normal)
        statsButton.setTitle("Stats", for: .normal)
        statsButton.translatesAutoresizingMaskIntoConstraints = false
        return statsButton
    }()
    
    let challengeButton: UIButton = {
        let reviewButton = UIButton()
        reviewButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        reviewButton.setTitleColor(.gray, for: .normal)
        reviewButton.setTitle("Challenges", for: .normal)
        reviewButton.translatesAutoresizingMaskIntoConstraints = false
        return reviewButton
    }()
    
    let faqButton: UIButton = {
        let castButton = UIButton()
        castButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        castButton.setTitleColor(.gray, for: .normal)
        castButton.setTitle("FAQs", for: .normal)
        castButton.translatesAutoresizingMaskIntoConstraints = false
        return castButton
    }()
    
    let categoryStackView: UIStackView = {
        let categoryStackView = UIStackView()
        categoryStackView.distribution = .fillEqually
        categoryStackView.alignment = .center
        categoryStackView.spacing = 0
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        return categoryStackView
    }()
    
    private var bottomBorder: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureActions()
    }
    
    private func configureUI(){
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoryStackView)
        categoryStackView.addArrangedSubview(statsButton)
        categoryStackView.addArrangedSubview(challengeButton)
        categoryStackView.addArrangedSubview(faqButton)
        setUpConstrains()
        addBottomBorder(to: statsButton)
    }
    
    private func configureActions() {
        statsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        challengeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        faqButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func setUpConstrains()
    {
        NSLayoutConstraint.activate([
            categoryStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryStackView.topAnchor.constraint(equalTo: topAnchor),
            categoryStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 41),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        addBottomBorder(to: sender)
        if sender == statsButton {
            delegate?.didTapStatsButton()
        } else if sender == challengeButton {
            delegate?.didTapChallengeButton()
        } else if sender == faqButton {
            delegate?.didTapFaqButton()
        }
    }
    
    private func addBottomBorder(to button: UIButton) {
        bottomBorder?.removeFromSuperview()
        statsButton.setTitleColor(.gray, for: .normal)
        challengeButton.setTitleColor(.gray, for: .normal)
        faqButton.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = AppFont.faqTextColor
        addSubview(border)
        NSLayoutConstraint.activate([
            border.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            border.heightAnchor.constraint(equalToConstant: 2)
        ])
        bottomBorder = border
    }
    
}
