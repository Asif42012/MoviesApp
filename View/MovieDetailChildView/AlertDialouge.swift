//
//  AlertDialouge.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import UIKit

class AlertsDialouge: UIViewController {
    var coordinator: MainCoordinator?
    
    let dialougeView: UIView = {
       let dialougeView = UIView()
        dialougeView.backgroundColor = .white
        dialougeView.layer.cornerRadius = 10
        dialougeView.layer.masksToBounds = true
        dialougeView.translatesAutoresizingMaskIntoConstraints = false
        return dialougeView
    }()
    
    let alertTitle: UILabel = {
        let alertTitle = UILabel()
        alertTitle.textColor = .red
        alertTitle.font = AppFont.regularPoppin16
        alertTitle.translatesAutoresizingMaskIntoConstraints = false
        return alertTitle
    }()
    
    let alertMessage: UILabel = {
       let alertMessage = UILabel()
        alertMessage.font = AppFont.regularPoppin14
        alertMessage.textColor = .black
        alertMessage.translatesAutoresizingMaskIntoConstraints = false
        return alertMessage
    }()
    
    let alertImage: UIImageView = {
        let alertImage = UIImageView(image: UIImage(systemName: "exclamationmark.bubble")?.withRenderingMode(.alwaysTemplate))
        alertImage.tintColor = .red.withAlphaComponent(0.6)
        alertImage.contentMode = .scaleAspectFit
        alertImage.translatesAutoresizingMaskIntoConstraints = false
        return alertImage
    }()
    
    let closeDialogeButton: UIButton = {
       let closeDialogeButton = UIButton()
        closeDialogeButton.backgroundColor = .blue.withAlphaComponent(0.5)
        closeDialogeButton.layer.cornerRadius = 10
        closeDialogeButton.layer.masksToBounds = true
        closeDialogeButton.setTitle("Close", for: .normal)
        closeDialogeButton.titleLabel?.textColor = .white
        closeDialogeButton.titleLabel?.font = AppFont.custom(weight: .bold, size: 16)
        closeDialogeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeDialogeButton
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        setUpConstrains()
        configureActions()
    }

    private func configureUi() {
        view.addSubview(dialougeView)
        dialougeView.addSubview(alertTitle)
        dialougeView.addSubview(alertMessage)
        dialougeView.addSubview(alertImage)
        dialougeView.addSubview(closeDialogeButton)
        view.backgroundColor = .gray.withAlphaComponent(0.6)
    }
    
    private func configureActions() {
        closeDialogeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureAlert(title: String, message: String, imageName: String, imageTintColor: UIColor) {
            alertTitle.text = title
            alertMessage.text = message
            if let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate) {
                alertImage.image = image
                alertImage.tintColor = imageTintColor
            }
        }
}

extension AlertsDialouge{
    private func setUpConstrains() {
        NSLayoutConstraint.activate([
            dialougeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dialougeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dialougeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            closeDialogeButton.leadingAnchor.constraint(equalTo: dialougeView.leadingAnchor, constant: 15),
            closeDialogeButton.trailingAnchor.constraint(equalTo: dialougeView.trailingAnchor, constant: -15),
            closeDialogeButton.bottomAnchor.constraint(equalTo: dialougeView.bottomAnchor, constant: -20),
            closeDialogeButton.heightAnchor.constraint(equalToConstant: 50),
            
            alertMessage.centerXAnchor.constraint(equalTo: dialougeView.centerXAnchor),
            alertMessage.bottomAnchor.constraint(equalTo: closeDialogeButton.topAnchor, constant: -20),
            
            alertTitle.centerXAnchor.constraint(equalTo: dialougeView.centerXAnchor),
            alertTitle.bottomAnchor.constraint(equalTo: alertMessage.topAnchor, constant: -20),
            
            alertImage.centerXAnchor.constraint(equalTo: dialougeView.centerXAnchor),
            alertImage.bottomAnchor.constraint(equalTo: alertTitle.topAnchor, constant: -20),
            alertImage.heightAnchor.constraint(equalToConstant: 40),
            alertImage.widthAnchor.constraint(equalToConstant: 50),
            alertImage.topAnchor.constraint(equalTo: dialougeView.topAnchor, constant: 40),
            
        ])
    }
}
