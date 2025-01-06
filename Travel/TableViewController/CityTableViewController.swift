//
//  CityTableViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit
import Kingfisher

class CityTableViewController: UITableViewController {

    private let list = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    private func configureAdCell(_ cell: AdTableViewCell, _ row: Int) {
        cell.adLabel.text = list[row].title
    }

    private func configureCityCell(_ cell: CityTableViewCell, _ row: Int) {
        let item = list[row]
        
        cell.cityImageView.kf.setImage(with: URL(string: item.travel_image ?? ""))
        cell.likeButton.isSelected = item.like ?? false
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.description
        cell.starview.rating = item.grade ?? 0
        cell.saveLabel.text = "· 저장 \(item.save?.formatted() ?? "")"
    }
}

extension CityTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let id = list[row].ad ? TravelConstants.adCellId : TravelConstants.cityCellId
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        list[row].ad
            ? configureAdCell(cell as! AdTableViewCell, row)
            : configureCityCell(cell as! CityTableViewCell, row)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
