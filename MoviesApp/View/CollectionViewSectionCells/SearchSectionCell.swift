//
//  SearchSectionCell.swift
//  MoviesApp
//
//  Created by Asif Hussain on 25/07/2024.
//

import UIKit

protocol SearchSectionCellDelegate: AnyObject{
    func searchCollectionViewCellDidSelect(cell: SearchSectionCell)
}

class SearchSectionCell: UICollectionViewCell {
    static let identifier = "SearchSectionCell"
    weak var delegate: SearchSectionCellDelegate?
    
    let title: UILabel = {
        let title = UILabel()
        title.font = AppFont.mediumPoppin18
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.contentMode = .center
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor(red: 103/255, green: 104/255, blue: 109/255, alpha: 1)
        //searchBar.tintColor = UIColor(hex: "858585")
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        searchBar.searchTextField.borderStyle = .none
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            if let searchIcon = UIImage(systemName: "magnifyingglass") {
                textFieldInsideSearchBar.rightView = UIImageView(image: searchIcon)
                textFieldInsideSearchBar.rightViewMode = .always
                textFieldInsideSearchBar.font = AppFont.regularPoppin14
                textFieldInsideSearchBar.textColor = UIColor(red: 103/255, green: 104/255, blue: 109/255, alpha: 1)
                textFieldInsideSearchBar.textAlignment = .left
            }
        }
        searchBar.isUserInteractionEnabled = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        configureUi()
        configureAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            searchBar.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func configure(with titles: String){
        title.text = titles
    }
    
    private func configureUi(){
        contentView.addSubview(title)
        contentView.addSubview(searchBar)
        setUpConstraints()
    }
    
    func configureAction() {
        isUserInteractionEnabled = true
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchBarTapped)))
    }
    
    @objc private func searchBarTapped() {
        delegate?.searchCollectionViewCellDidSelect(cell: self)
        print("Search Cell Tapped")
    }
}
