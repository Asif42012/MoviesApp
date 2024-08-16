//
//  AlertDialogue.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import UIKit

class AlertsDialogue: UIViewController {
    var coordinator: MainCoordinator?
    
    let dialogueView: UIView = {
        let dialogueView = UIView()
        dialogueView.backgroundColor = .white
        dialogueView.layer.cornerRadius = 10
        dialogueView.layer.masksToBounds = true
        dialogueView.translatesAutoresizingMaskIntoConstraints = false
        return dialogueView
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
    
    let closeDialogueButton: UIButton = {
        let closeDialogueButton = UIButton()
        closeDialogueButton.backgroundColor = .blue.withAlphaComponent(0.5)
        closeDialogueButton.layer.cornerRadius = 10
        closeDialogueButton.layer.masksToBounds = true
        closeDialogueButton.setTitle("Close", for: .normal)
        closeDialogueButton.titleLabel?.textColor = .white
        closeDialogueButton.titleLabel?.font = AppFont.custom(weight: .bold, size: 16)
        closeDialogueButton.translatesAutoresizingMaskIntoConstraints = false
        return closeDialogueButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        setUpConstrains()
        configureActions()
    }
    
    private func configureUi() {
        view.addSubview(dialogueView)
        dialogueView.addSubview(alertTitle)
        dialogueView.addSubview(alertMessage)
        dialogueView.addSubview(alertImage)
        dialogueView.addSubview(closeDialogueButton)
        view.backgroundColor = .gray.withAlphaComponent(0.6)
    }
    
    private func configureActions() {
        closeDialogueButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
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

extension AlertsDialogue{
    private func setUpConstrains() {
        NSLayoutConstraint.activate([
            dialogueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dialogueView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dialogueView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            closeDialogueButton.leadingAnchor.constraint(equalTo: dialogueView.leadingAnchor, constant: 15),
            closeDialogueButton.trailingAnchor.constraint(equalTo: dialogueView.trailingAnchor, constant: -15),
            closeDialogueButton.bottomAnchor.constraint(equalTo: dialogueView.bottomAnchor, constant: -20),
            closeDialogueButton.heightAnchor.constraint(equalToConstant: 50),
            
            alertMessage.centerXAnchor.constraint(equalTo: dialogueView.centerXAnchor),
            alertMessage.bottomAnchor.constraint(equalTo: closeDialogueButton.topAnchor, constant: -20),
            
            alertTitle.centerXAnchor.constraint(equalTo: dialogueView.centerXAnchor),
            alertTitle.bottomAnchor.constraint(equalTo: alertMessage.topAnchor, constant: -20),
            
            alertImage.centerXAnchor.constraint(equalTo: dialogueView.centerXAnchor),
            alertImage.bottomAnchor.constraint(equalTo: alertTitle.topAnchor, constant: -20),
            alertImage.heightAnchor.constraint(equalToConstant: 40),
            alertImage.widthAnchor.constraint(equalToConstant: 50),
            alertImage.topAnchor.constraint(equalTo: dialogueView.topAnchor, constant: 40),
            
        ])
    }
}
