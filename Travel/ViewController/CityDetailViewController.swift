//
//  CityDetailViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-08.
//

import UIKit
import Kingfisher

class CityDetailViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var popButton: UIButton!

    var info: Travel?
    
    static let id = getId()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        configureNavigationBar()
        configureImageView()
        configureTitleLabel()
        configureSubtitleLabel()
        configurePopButton()
        configureData(info)
    }
    
    private func configureNavigationBar() {
        title = "관광지 화면"
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = TravelConstants.cornerRadius
    }
    
    private func configureTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureSubtitleLabel() {
        subtitleLabel.numberOfLines = TravelConstants.numberOfLines
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = .boldSystemFont(ofSize: TravelConstants.boldSize)
    }
    
    private func configurePopButton() {
        let buttonTitle = "다른 관광지 보러 가기"
        let inset: CGFloat = 10
        
        var config = UIButton.Configuration.filled()
        config.title = buttonTitle
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .systemBlue.withAlphaComponent(0.6)
        config.titleAlignment = .center
        config.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        config.cornerStyle = .capsule
        
        popButton.configuration = config
        popButton.addTarget(self, action: #selector(popButtonTapped), for: .touchUpInside)
    }
    
    private func configureData(_ item: Travel?) {
        imageView.kf.setImage(with: URL(string: item?.travel_image ?? ""))
        titleLabel.text = item?.title
        subtitleLabel.text = item?.description
    }
    
    @objc
    private func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
