//
//  ButtonsStackView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import UIKit

protocol ButtonsStackViewDelegate: AnyObject {
    func didTapAboutButton()
    func didTapReviewButton()
    func didTapCastButton()
}

class ButtonsStackView: UIView {
    weak var delegate: ButtonsStackViewDelegate?
    let aboutButton: UIButton = {
        let aboutButton = UIButton()
        aboutButton.titleLabel?.font = AppFont.regularPoppin14
        aboutButton.setTitleColor(.white, for: .normal)
        aboutButton.setTitle("About Movie", for: .normal)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        return aboutButton
    }()
    
    let reviewButton: UIButton = {
        let reviewButton = UIButton()
        reviewButton.titleLabel?.font = AppFont.regularPoppin14
        reviewButton.setTitleColor(.white, for: .normal)
        reviewButton.setTitle("Reviews", for: .normal)
        reviewButton.translatesAutoresizingMaskIntoConstraints = false
        return reviewButton
    }()
    
    let castButton: UIButton = {
        let castButton = UIButton()
        castButton.titleLabel?.font = AppFont.regularPoppin14
        castButton.setTitleColor(.white, for: .normal)
        castButton.setTitle("Cast", for: .normal)
        castButton.translatesAutoresizingMaskIntoConstraints = false
        return castButton
    }()
    
    let buttonsStakView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsStackView
    }()
    
    private var bottomBorder: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureActions()
    }
    
    private func configureUI(){
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonsStakView)
        buttonsStakView.addArrangedSubview(aboutButton)
        buttonsStakView.addArrangedSubview(reviewButton)
        buttonsStakView.addArrangedSubview(castButton)
        setUpConstrains()
        addBottomBorder(to: aboutButton)
    }
    
    private func configureActions() {
        aboutButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        reviewButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        castButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func setUpConstrains()
    {
        NSLayoutConstraint.activate([
            buttonsStakView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsStakView.topAnchor.constraint(equalTo: topAnchor),
            buttonsStakView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonsStakView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 41),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        addBottomBorder(to: sender)
        if sender == aboutButton {
            delegate?.didTapAboutButton()
        } else if sender == reviewButton {
            delegate?.didTapReviewButton()
        } else if sender == castButton {
            delegate?.didTapCastButton()
        }
    }
    
    private func addBottomBorder(to button: UIButton) {
        bottomBorder?.removeFromSuperview()
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(red: 58/255, green: 63/255, blue: 71/255, alpha: 1)
        addSubview(border)
        NSLayoutConstraint.activate([
            border.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            border.heightAnchor.constraint(equalToConstant: 4)
        ])
        bottomBorder = border
    }
}

