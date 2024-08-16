//
//  NavBarView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

protocol NavBarViewButtonDidTapDelegate: AnyObject {
    func backButtonDidTap()
    
}

class NavBarView: UIView {
    weak var delegate: NavBarViewButtonDidTapDelegate? = nil
    
    let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "Ic_leftArrow"), for: .normal)
        backButton.contentMode = .center
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUi()
        configureAction()
    }
    
    private func configureUi() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addSubview(backButton)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            backButton.topAnchor.constraint(equalTo:topAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
        ])
    }
    
    func configureAction() {
        backButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
    }
    
    @objc private func popView() {
        delegate?.backButtonDidTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

