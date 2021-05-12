//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Ahmet Acar on 12.05.2021.
//

import UIKit
import SnapKit

final class NewsDetailViewController: UIViewController {
    
    var viewModel = NewsDetailViewModel()
    
// MARK: - UI Properties
    
    private lazy var newsImage: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        image.image = NewsImages.placeholder
        return image
    }()
    
    private lazy var newsTitle: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 0 // 2
        return titleLabel
    }()
    
    private lazy var newsDescription: UILabel = {
        let newsLabel = UILabel()
        newsLabel.font = UIFont.systemFont(ofSize: 16)
        newsLabel.numberOfLines = 0
        return newsLabel
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var authorView = NewsAdditionalInfoView(text: viewModel.news?.author ?? "Unknown", contentType: .authorInfoView)
    
    private lazy var dateView = NewsAdditionalInfoView(text: viewModel.news?.publishDate ?? "Unknown", contentType: .dateView)
    
    private lazy var additionalInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorView, dateView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var newsPageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Keep Reading", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15.0
        button.backgroundColor = .systemGray4
        return button
    }()
    
// MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        scrollView.backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
        viewModel.delegate = self
        
        newsImage.load(stringURL: viewModel.news?.image)
        newsTitle.text = viewModel.news?.title
        newsDescription.text = viewModel.news?.content
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(newsImage)
        contentView.addSubview(newsTitle)
        contentView.addSubview(additionalInfoStackView)
        contentView.addSubview(newsDescription)
        view.addSubview(newsPageButton)
    }
    
    override func viewDidLayoutSubviews() {
        
        newsImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(view.snp.height).multipliedBy(0.35)
        }

        newsTitle.snp.makeConstraints { (make) in
            make.top.equalTo(newsImage.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(view.snp.height).multipliedBy(0.05)
        }

        additionalInfoStackView.snp.makeConstraints { (make) in
            make.top.equalTo(newsTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.height.equalTo(view.snp.height).multipliedBy(0.05)
        }

        newsDescription.snp.makeConstraints { (make) in
            make.top.equalTo(additionalInfoStackView.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(12)
            make.right.equalTo(contentView.snp.right).offset(-12)
            make.bottom.equalTo(contentView.snp.bottom)
        }

        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }

        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        newsPageButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-4)
            make.height.equalTo(view.snp.height).multipliedBy(0.05)
        }
    }
}

//MARK: - Extension NewsDetailViewModelDelegate

extension NewsDetailViewController: NewsDetailViewModelDelegate {
    func apiRequestCompleted() {
        print("done")
    }
}
