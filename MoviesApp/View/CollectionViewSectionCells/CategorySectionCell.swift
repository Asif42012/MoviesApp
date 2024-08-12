//
//  CategorySectionCell.swift
//  MoviesApp
//
//  Created by Asif Hussain on 26/07/2024.
//

import UIKit

protocol CategorySectionCellDelegate: AnyObject {
    func allMovieCollectionViewCellDidSelect(cell: CategorySectionCell)
}

class CategorySectionCell: UICollectionViewCell {
    static let identifier = "CategorySectionCell"
    weak var delegate: CategorySectionCellDelegate?
    
    private var bottomBorder: UIView?
    
    let categoryButton: UIButton = {
        let categoryButton = UIButton()
        categoryButton.titleLabel?.font = AppFont.regularPoppin14
        categoryButton.titleLabel?.textColor = .white
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        return categoryButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureAction()
        addBottomBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: topAnchor),
            categoryButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func configure(with category: MovieCategory, isSelected: Bool) {
        categoryButton.setTitle(category.categoryName.rawValue, for: .normal)
        showOrHideBottomBorderView(isShow: isSelected)
    }
    
    private func configureUI() {
        contentView.addSubview(categoryButton)
        setUpConstraints()
    }
    
    private func configureAction() {
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
    }
    
    @objc private func categoryButtonTapped() {
        delegate?.allMovieCollectionViewCellDidSelect(cell: self)
    }
    
    private func addBottomBorder() {
        bottomBorder?.removeFromSuperview()
        let border = UIView()
        border.alpha = 0
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(red: 58/255, green: 63/255, blue: 71/255, alpha: 1)
        addSubview(border)
        NSLayoutConstraint.activate([
            border.leadingAnchor.constraint(equalTo: categoryButton.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: categoryButton.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: categoryButton.bottomAnchor),
            border.heightAnchor.constraint(equalToConstant: 4)
        ])
        bottomBorder = border
    }
    
    private func showOrHideBottomBorderView(isShow: Bool) {
        bottomBorder?.alpha = isShow ? 1 : 0
    }
}
