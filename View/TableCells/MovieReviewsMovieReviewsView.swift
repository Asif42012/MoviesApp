//
//  MovieReviewsSection.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import UIKit

class MovieReviewsView: UITableViewCell {
    static let identifier = "MovieReviewsView"
    
    let userImageView: UIView = {
        let userImageView = UIView()
        userImageView.layer.cornerRadius = 22
        userImageView.layer.masksToBounds = true
        userImageView.backgroundColor = UIColor(red: 89/255, green: 64/255, blue: 92/255, alpha: 1)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        return userImageView
    }()
    
    let userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.contentMode = .scaleAspectFill
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
    let userName: UILabel = {
        let userName = UILabel()
        userName.font = AppFont.bold12
        userName.textColor = .white
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()
    
    let userComment: UILabel = {
        let userComment = UILabel()
        userComment.font = AppFont.medium12
        userComment.textColor = .white
        userComment.numberOfLines = 0
        userComment.translatesAutoresizingMaskIntoConstraints = false
        return userComment
    }()
    
    let userRating: UILabel = {
        let userRating = UILabel()
        userRating.font = AppFont.medium12
        userRating.text = "6.6"
        userRating.textColor = .blue.withAlphaComponent(0.8)
        userRating.translatesAutoresizingMaskIntoConstraints = false
        return userRating
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    private func configureUI(){
        contentView.addSubview(userImageView)
        userImageView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(userRating)
        contentView.addSubview(userComment)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userImageView.heightAnchor.constraint(equalToConstant: 44),
            userImageView.widthAnchor.constraint(equalToConstant: 44),
            userImage.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            userImage.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor),
            userImage.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor),
            
            userName.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            userRating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            userRating.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            
            userComment.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            userComment.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 4),
            userComment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            userComment.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    override func prepareForReuse() {
        userName.text = nil
        userRating.text = nil
        userComment.text = nil
        userImage.image = nil
    }
    
    func configure(with review: Review) {
        userName.text = review.author
        if let rating = review.authorDetails.rating {
            userRating.text = String(rating)
        } else {
            userRating.text = "No Rating"
        }
        userComment.text = review.content
        userImage.downloadImages(with: review.authorDetails.avatarPath ?? "")
    }
}
