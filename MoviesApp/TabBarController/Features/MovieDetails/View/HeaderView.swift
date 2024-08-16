//
//  HeaderView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 09/08/2024.
//

import UIKit

protocol HeaderViewButtonDidTapDelegate: AnyObject {
    func backButtonDidTap()
    func saveButtonDidTap()
}

class HeaderView: UIView {
    weak var delegate: HeaderViewButtonDidTapDelegate? = nil
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Details"
        titleLabel.textColor = .white
        titleLabel.font = AppFont.regularPoppin16
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let backButton: UIButton = {
        let backButton = UIButton()
        if let image = UIImage(systemName: "arrow.left") {
            backButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        backButton.tintColor = .white
        backButton.contentMode = .center
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setImage(UIImage(named: "Ic_bookMark"), for: .normal)
        saveButton.contentMode = .center
        if let image = UIImage(named: "Ic_bookMark") {
            saveButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        saveButton.tintColor = .white
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUi()
        configureAction()
    }
    
    private func configureUi() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(saveButton)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo:topAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    func configureAction() {
        backButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveCurrentMovie), for: .touchUpInside)
    }
    
    @objc private func popView() {
        delegate?.backButtonDidTap()
    }
    
    @objc private func saveCurrentMovie() {
        delegate?.saveButtonDidTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
