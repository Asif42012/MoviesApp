//
//  FAQsViewController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

class FAQsViewController: BaseViewController {
    
    private let coordinator: MainCoordinator
    private let viewModel: GemsFAQViewModel
    private let headerView = NavBarView()
    private let categoryButtons = CategorySelectionView()
    private let scrollView = UIScrollView()
    private let contentView = FAQContentView()
    private let dummyView = DummyView()
    
    init(coordinator: MainCoordinator, viewModel: GemsFAQViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayContent()
        contentView.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        contentView.isHidden = true
        UISetupHelper.setupHeaderView(in: view, headerView: headerView)
        UISetupHelper.setupScrollView(in: view, scrollView: scrollView, below: headerView)
        UISetupHelper.setupTopStackButtons(in: scrollView, categoryButtons: categoryButtons, delegate: self)
        
        UISetupHelper.setupContentView(in: scrollView, contentView: contentView, below: categoryButtons, parentView: view, delegate: self)
    }
    
    private func displayContent() {
        contentView.configure(with: viewModel.getAttributedText())
    }
}

extension FAQsViewController: FAQContentViewDelegate {
    func didTapConfidantClubMembers() {
        print("Confidant Club members tapped!")
    }
}

extension FAQsViewController: CategorySelectionViewDelegate {
    func didTapStatsButton() {
        dummyView.isHidden = false
        contentView.isHidden = true
    }
    
    func didTapChallengeButton() {
        dummyView.isHidden = false
        contentView.isHidden = true
    }
    
    func didTapFaqButton() {
        dummyView.isHidden = true
        contentView.isHidden = false
    }
}

