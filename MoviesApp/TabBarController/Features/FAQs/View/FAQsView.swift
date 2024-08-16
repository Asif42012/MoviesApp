//
//  FAQsView.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

protocol FAQContentViewDelegate: AnyObject {
    func didTapConfidantClubMembers()
}

class FAQContentView: UIView {
    
    weak var delegate: FAQContentViewDelegate?
    
    private let contentLabel: UITextView = {
        let contentLabel = UITextView()
        contentLabel.isEditable = false
        contentLabel.isScrollEnabled = false
        contentLabel.isSelectable = true
        contentLabel.dataDetectorTypes = [.link]
        contentLabel.linkTextAttributes = [
            .foregroundColor: UIColor.systemPink,
            .underlineStyle: 0
        ]
        contentLabel.textColor = AppFont.faqTextColor
        contentLabel.backgroundColor = .clear
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        return contentLabel
    }()
    
    let headingTitle: UILabel = {
        let headingTitle = UILabel()
        headingTitle.text = "Gems FAQ"
        headingTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        headingTitle.textColor = AppFont.faqTextColor
        headingTitle.translatesAutoresizingMaskIntoConstraints = false
        return headingTitle
    }()
    private let gemImageView = GemImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(headingTitle)
        addSubview(contentLabel)
        addSubview(gemImageView)
        
        NSLayoutConstraint.activate([
            headingTitle.topAnchor.constraint(equalTo: topAnchor),
            headingTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentLabel.topAnchor.constraint(equalTo: headingTitle.bottomAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: gemImageView.topAnchor, constant: -16),
            
            gemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gemImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configure(with text: NSAttributedString) {
        contentLabel.attributedText = text
    }
}


extension FAQContentView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "https://www.google.com/" {
            delegate?.didTapConfidantClubMembers()
            return false // Prevent default action
        }
        return true
    }
}
