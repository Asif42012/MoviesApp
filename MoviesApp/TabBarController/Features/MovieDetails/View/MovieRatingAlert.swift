//
//  MovieRatingAlert.swift
//  MoviesApp
//
//  Created by Asif Hussain on 05/08/2024.
//

import UIKit

protocol MovieRatingControllerDelegate: AnyObject {
    func didSubmitRating(_ rating: Double)
}

class MovieRatingAlert: UIViewController {
    var coordinator: MainCoordinator?
    weak var delegate: MovieRatingControllerDelegate?
    
    private let sheetHeight: CGFloat = 263
    private let animationDuration: TimeInterval = 0.3
    private var isSheetVisible = false
    
    let sheetView: UIView = {
        let sheetView = UIView()
        sheetView.backgroundColor = .white
        sheetView.layer.cornerRadius = 20
        sheetView.layer.masksToBounds = true
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        return sheetView
    }()
    
    let crossButton: UIButton = {
        let crossButton = UIButton()
        crossButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        if let image = UIImage(systemName: "multiply") {
            crossButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        crossButton.tintColor = UIColor(red: 160/255, green: 163/255, blue: 189/255, alpha: 1)
        crossButton.contentMode = .center
        crossButton.imageView?.contentMode = .scaleAspectFit
        crossButton.translatesAutoresizingMaskIntoConstraints = false
        return crossButton
    }()
    
    let sheetTitle: UILabel = {
        let sheetTitle = UILabel()
        sheetTitle.text = "Rate this movie"
        sheetTitle.font = AppFont.mediumPoppin18
        sheetTitle.textColor = UIColor(red: 78/255, green: 75/255, blue: 102/255, alpha: 1)
        sheetTitle.translatesAutoresizingMaskIntoConstraints = false
        return sheetTitle
    }()
    
    let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = AppFont.regularPoppin32
        ratingLabel.textColor = UIColor(red: 78/255, green: 75/255, blue: 102/255, alpha: 1)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()
    
    let okButton: UIButton = {
        let okButton = UIButton()
        okButton.backgroundColor = .blue.withAlphaComponent(0.6)
        okButton.setTitle("Ok", for: .normal)
        okButton.layer.cornerRadius = 28
        okButton.layer.masksToBounds = true
        okButton.titleLabel?.font = AppFont.medium12
        okButton.translatesAutoresizingMaskIntoConstraints = false
        return okButton
    }()
    
    lazy var ratingSlider: ThickSlider = {
        let ratingSlider = ThickSlider()
        ratingSlider.maximumValue = 5.0
        ratingSlider.minimumValue = 0.0
        ratingSlider.value = 2.5
        ratingSlider.trackHeight = 10.0 // Set the track height
        
        let trackSize = CGSize(width: 1, height: 10)
        let cornerRadius: CGFloat = 5.0 // Set the desired corner radius
        let orangeTrackImage = createTrackImage(color: .orange, size: trackSize, cornerRadius: cornerRadius)
        let grayTrackImage = createTrackImage(color: .lightGray.withAlphaComponent(0.6), size: trackSize, cornerRadius: cornerRadius)
        
        let thumbDiameter: CGFloat = 30.0
        let thumbCornerRadius: CGFloat = thumbDiameter / 2 // Makes it a circle
        let thumbImage = createThumbImage(color: .white, diameter: thumbDiameter, cornerRadius: thumbCornerRadius)
        
        ratingSlider.setMinimumTrackImage(orangeTrackImage, for: .normal)
        ratingSlider.setMaximumTrackImage(grayTrackImage, for: .normal)
        ratingSlider.setThumbImage(thumbImage, for: .normal)
        
        ratingSlider.translatesAutoresizingMaskIntoConstraints = false
        return ratingSlider
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        setUpConstrains()
        configureActions()
    }
    
    private func configureActions() {
        okButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        ratingSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        crossButton.addTarget(self, action: #selector(crossButtonTapped), for: .touchUpInside)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        ratingLabel.text = String(format: "%.2f", sender.value)
    }
    
    @objc private func closeTapped() {
        let formattedRating = Double(round(10 * ratingSlider.value) / 10)
        delegate?.didSubmitRating(Double(formattedRating))
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func crossButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    func configureUi() {
        view.backgroundColor = .black.withAlphaComponent(0.7)
        view.addSubview(sheetView)
        sheetView.addSubview(crossButton)
        sheetView.addSubview(ratingLabel)
        sheetView.addSubview(sheetTitle)
        sheetView.addSubview(ratingSlider)
        sheetView.addSubview(okButton)
    }
    
    func setUpConstrains(){
        NSLayoutConstraint.activate([
            sheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            okButton.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 65),
            okButton.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -65),
            okButton.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor, constant: -20),
            okButton.heightAnchor.constraint(equalToConstant: 56),
            
            
            ratingSlider.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 35),
            ratingSlider.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -35),
            ratingSlider.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -20),
            
            ratingLabel.bottomAnchor.constraint(equalTo: ratingSlider.topAnchor, constant: -20),
            ratingLabel.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor),
            
            sheetTitle.bottomAnchor.constraint(equalTo: ratingLabel.topAnchor, constant: -25),
            sheetTitle.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 25),
            sheetTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            crossButton.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -15),
            crossButton.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 15),
            crossButton.heightAnchor.constraint(equalToConstant: 24),
            crossButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        sheetView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        ratingLabel.text = String(ratingSlider.value)
    }
    
    func createTrackImage(color: UIColor, size: CGSize, cornerRadius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let rect = CGRect(origin: .zero, size: size)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        
        context.addPath(path.cgPath)
        context.clip() // Apply clipping
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image?.resizableImage(withCapInsets: .zero)
    }
    
    
    func createThumbImage(color: UIColor, diameter: CGFloat, cornerRadius: CGFloat) -> UIImage? {
        let size = CGSize(width: diameter, height: diameter)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: .zero, size: size)
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        context?.addPath(path.cgPath)
        context?.clip() // Apply the clipping to the path
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        context?.setStrokeColor(UIColor.orange.cgColor)
        context?.setLineWidth(4.0)
        context?.strokeEllipse(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image?.withRenderingMode(.alwaysOriginal)
    }
}
